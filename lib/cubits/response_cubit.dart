import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
  late Response response;

  void loadResponse(
      String url,
      String method,{
        Map<String, dynamic>? bodyMap,
        Map<String, dynamic>? expectedMap,
        String? authToken,
  }) async {
    emit(ResponseLoading());

    final start = DateTime.now();
    if (url.isEmpty) {
      emit(ResponseFailure(message: "URL cannot be empty"));
      return;
    }
    Map<String, dynamic> requestHeaders = {};
    if (authToken != null && authToken.isNotEmpty) {
      requestHeaders['Authorization'] = 'Bearer $authToken';
    }

    Options options = Options(
      headers: requestHeaders.isNotEmpty ? requestHeaders : null,
    );

    try{
      if(method == 'GET') {
        response = await dio.get(url, data: bodyMap, options: options);
      } else if(method == 'POST') {
        response = await dio.post(url, data: bodyMap, options: options);
      } else if(method == 'PUT') {
        response = await dio.put(url, data: bodyMap, options: options);
      } else if(method == 'DELETE') {
        response = await dio.delete(url, data: bodyMap, options: options);
      } else {
        response = await dio.patch(url, data: bodyMap, options: options);
      }

      final end = DateTime.now();

      int verdict = 0;
      int found = 0;

      if(expectedMap != null && expectedMap.isNotEmpty) {
        for(var map in expectedMap.entries) {
          if(response.data is List) {
            for(int i=0; i<response.data.length; i++) {
              if(response.data[i] != null && response.data[i][map.key] != null) {
                if(map.value == "<<<Anything>>>" || response.data[i][map.key].toString() == map.value.toString()) {
                  found++;
                }
              }
            }
          } else {
            if(response.data != null && response.data[map.key] != null) {
              if(map.value == "<<<Anything>>>" || response.data[map.key].toString() == map.value.toString()) {
                found++;
              }
            }
          }
        }
      }
      if(found == expectedMap?.length) {
        verdict = 1;
      } else {
        verdict = 2;
      }

      const JsonEncoder encoder = JsonEncoder.withIndent('    ');
      String formattedBody = encoder.convert(response.data);

      String expectedString = '';
      if(expectedMap != null && expectedMap.isNotEmpty) {
        expectedString = encoder.convert(expectedMap);
      }

      emit(ResponseLoaded(
        statusCode: response.statusCode ?? 0,
        statusMessage: response.statusMessage ?? '',
        headers: response.headers.map.toString(),
        body: formattedBody,
        time: end.difference(start).inMilliseconds,
        size: response.data?.toString().length ?? 0,
        verdict: verdict,
        expected: expectedString,
      ));
    }catch (e) {
      emit(ResponseFailure(message: e.toString()));
      return;
    }
  }
}
