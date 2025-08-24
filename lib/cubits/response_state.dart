part of 'response_cubit.dart';

@immutable
sealed class ResponseState {}

final class ResponseInitial extends ResponseState {}

final class ResponseLoading extends ResponseState {}

final class ResponseLoaded extends ResponseState {
  final int? statusCode;
  final String statusMessage;
  final String headers;
  final String body;
  final int time;
  final int size;
  final int? verdict;
  final String? expected;

  ResponseLoaded({
    required this.statusCode,
    required this.statusMessage,
    required this.headers,
    required this.body,
    required this.time,
    required this.size,
    this.verdict,
    this.expected,
  });
}

final class ResponseFailure extends ResponseState {
  final String message;

  ResponseFailure({required this.message});
}
