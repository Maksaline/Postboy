part of 'collection_cubit.dart';

@immutable
sealed class CollectionState {}

class CollectionInitial extends CollectionState {}

class CollectionLoading extends CollectionState {}

class CollectionLoaded extends CollectionState {
  final String method;
  final String url;
  final Map<String, String> headers;
  final Map<String, String> body;
  final String authToken;
  final Map<String, Map<String, dynamic>> automation;
  final int count;
  final Map<String, String> expected;

  CollectionLoaded({
    required this.method,
    required this.url,
    required this.headers,
    required this.body,
    required this.authToken,
    required this.automation,
    required this.count,
    required this.expected,
  });
}

class CollectionFailure extends CollectionState {
  final String message;

  CollectionFailure({required this.message});
}