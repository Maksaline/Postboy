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

      const JsonEncoder encoder = JsonEncoder.withIndent('    ');
      String formattedBody = encoder.convert(response.data);

      emit(ResponseLoaded(
        statusCode: response.statusCode ?? 0,
        statusMessage: response.statusMessage ?? '',
        headers: response.headers.map.toString(),
        body: formattedBody,
        time: end.difference(start).inMilliseconds,
        size: response.data?.toString().length ?? 0,
      ));
    }catch (e) {
      emit(ResponseFailure(message: e.toString()));
      return;
    }
  }
}
