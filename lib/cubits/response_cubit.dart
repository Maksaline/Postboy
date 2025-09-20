import 'dart:convert';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../helpers/name_generator.dart';

part 'response_state.dart';

class ResponseCubit extends Cubit<ResponseState> {
  ResponseCubit() : super(ResponseInitial());
  final dio = Dio(
    BaseOptions(
      validateStatus: (status) {
        return status != null;
      }
    )
  );
  Random rand = Random();
  late Response response;

  void loadResponse(
      String url,
      String method,{
        Map<String, dynamic>? bodyMap,
        Map<String, dynamic>? expectedMap,
        Map<String, dynamic>? automationMap,
        String? authToken,
        int? count,
  }) async {
    emit(ResponseLoading());

    try {
      final start = DateTime.now();
      if (url.isEmpty) {
        emit(ResponseFailure(message: "URL cannot be empty"));
        return;
      }

      const JsonEncoder encoder = JsonEncoder.withIndent('    ');

      Map<String, dynamic> requestHeaders = {};
      if (authToken != null && authToken.isNotEmpty) {
        requestHeaders['Authorization'] = 'Bearer $authToken';
      }

      Options options = Options(
        headers: requestHeaders.isNotEmpty ? requestHeaders : null,
      );

      List<dynamic> responses = [];
      dynamic newValue;
      if (automationMap != null && automationMap.isNotEmpty && count != null &&
          count > 0 && bodyMap != null && bodyMap.isNotEmpty) {
        for (int i = 0; i < count; i++) {
          Map<String, dynamic> newRes = {};
          Map<String, dynamic> newData = {};
          bodyMap.forEach((key, value) {
            if (bodyMap[key] != '<<<Automation>>>') {
              newValue = bodyMap[key];
            } else {
              Map<String, dynamic> val = automationMap[key];
              int lower = val['lower'] ?? 0;
              int upper = val['upper'] ?? 0;
              if (val['type'] == 'Int') {
                if (val['option'] == 'Random') {
                  newValue = lower + rand.nextInt(upper - lower + 1);
                } else {
                  newValue = min(lower + i, upper);
                }
              } else if (val['type'] == 'Double') {
                double randomDouble = lower + rand.nextDouble() * (upper - lower);
                if (val['option'] == 'Random') {
                  newValue = double.parse(randomDouble.toStringAsFixed(2));
                } else {
                  newValue = double.parse(min(lower + i, upper).toStringAsFixed(2));
                }
              } else if (val['type'] == 'String') {
                if (val['option'] == 'Random') {
                  int length = lower + rand.nextInt(upper - lower + 1);
                  length = length > 20 ? 20 : length < 1 ? 1 : length;
                  newValue = NameGenerator.generateRandomName(length);
                } else {
                  int length = min(lower + i, upper);
                  if (length > 20) {
                    length = 20;
                  } else if (length < 1) {
                    length = 1;
                  }
                  newValue = NameGenerator.generateRandomName(length);
                }
              } else if (val['type'] == 'Bool') {
                newValue = val['option'] == 'Random' ? rand.nextBool() : (i % 2 == 0);
              }
            }
            newData[key] = newValue;
            newRes['${i + 1}-$key'] = newValue;
          });

          try {
            if (method == 'GET') {
              response = await dio.get(url, data: newData, options: options);
            } else if (method == 'POST') {
              response = await dio.post(url, data: newData, options: options);
            } else if (method == 'PUT') {
              response = await dio.put(url, data: newData, options: options);
            } else if (method == 'DELETE') {
              response = await dio.delete(url, data: newData, options: options);
            } else {
              response = await dio.patch(url, data: newData, options: options);
            }

            newRes['${i + 1}-StatusCode'] =
                '${response.statusCode} ${response.statusMessage}';
            responses.add(newRes);
          } catch (e) {
            emit(ResponseFailure(message: e.toString()));
            return;
          }
        }
        final end = DateTime.now();
        String autoBody = encoder.convert(responses);

        emit(ResponseLoaded(
          statusCode: 0,
          statusMessage: 'Automation Completed',
          headers: '',
          body: autoBody,
          time: end
              .difference(start)
              .inMilliseconds,
          size: autoBody
              .toString()
              .length,
        ));
      } else {
        try {
          if (method == 'GET') {
            response = await dio.get(url, data: bodyMap, options: options);
          } else if (method == 'POST') {
            response = await dio.post(url, data: bodyMap, options: options);
          } else if (method == 'PUT') {
            response = await dio.put(url, data: bodyMap, options: options);
          } else if (method == 'DELETE') {
            response = await dio.delete(url, data: bodyMap, options: options);
          } else {
            response = await dio.patch(url, data: bodyMap, options: options);
          }

          final end = DateTime.now();

          int verdict = 0;
          Map<int, int> keysChecked = {};

          if (expectedMap != null && expectedMap.isNotEmpty) {
            for (var map in expectedMap.entries) {
              int i = 0;
              if (response.data is List) {
                for (i = 0; i < response.data.length; i++) {
                  if (response.data[i] != null &&
                      response.data[i][map.key] != null) {
                    if (map.value == "<<<Anything>>>" ||
                        response.data[i][map.key].toString() ==
                            map.value.toString()) {
                      keysChecked[i] =
                      keysChecked[i] != null ? keysChecked[i]! + 1 : 1;
                    }
                  }
                }
              } else {
                if (response.data != null && response.data[map.key] != null) {
                  if (map.value == "<<<Anything>>>" ||
                      response.data[map.key].toString() ==
                          map.value.toString()) {
                    keysChecked[i] =
                    keysChecked[i] != null ? keysChecked[i]! + 1 : 1;
                  }
                }
              }
            }
          }
          int max = 0;
          keysChecked.forEach((key, value) {
            if (value > max) {
              max = value;
            }
          });
          if (max == expectedMap?.length) {
            verdict = 1;
          } else {
            verdict = 2;
          }
          if (expectedMap == null || expectedMap.isEmpty) {
            verdict = 0;
          }


          String formattedBody = encoder.convert(response.data);

          String expectedString = '';
          if (expectedMap != null && expectedMap.isNotEmpty) {
            expectedString = encoder.convert(expectedMap);
          }

          emit(ResponseLoaded(
            statusCode: response.statusCode ?? 0,
            statusMessage: response.statusMessage ?? '',
            headers: response.headers.map.toString(),
            body: formattedBody,
            time: end
                .difference(start)
                .inMilliseconds,
            size: response.data
                ?.toString()
                .length ?? 0,
            verdict: verdict,
            expected: expectedString,
          ));
        } catch (e) {
          emit(ResponseFailure(message: e.toString()));
          return;
        }
      }
    } catch (e) {
      emit(ResponseFailure(message: e.toString()));
      return;
    }
  }
}
