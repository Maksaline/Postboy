part of 'collection_cubit.dart';

@immutable
sealed class CollectionState {}

class CollectionInitial extends CollectionState {}

class CollectionLoading extends CollectionState {}

class CollectionLoaded extends CollectionState {
  final List<Collection> collections;
  final int index;

  CollectionLoaded({
    required this.collections,
    required this.index,
  });
}

class CollectionFailure extends CollectionState {
  final String message;

  CollectionFailure({required this.message});
}