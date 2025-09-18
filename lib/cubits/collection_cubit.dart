import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

import '../models/collection.dart';

part 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  CollectionCubit() : super(CollectionInitial());
  List<Collection> collections = [];
  int index = 0;

  void addNewCollection() {
    emit(CollectionLoading());
    try {
      int newIndex = collections.length;
      collections.add(
        Collection(
          name: 'New Request',
          id: newIndex,
          method: 'GET',
        )
      );
      emit(CollectionLoaded(collections: collections, index: index));
    } catch (e) {
      emit(CollectionFailure(message: e.toString()));
    }
  }

  void loadCollections() {
    emit(CollectionLoading());
    try {
      // Here you can load collections from a database or API if needed
      emit(CollectionLoaded(collections: collections, index: index));
    } catch (e) {
      emit(CollectionFailure(message: e.toString()));
    }
  }

  void updateIndex(int newIndex) {
    index = newIndex;
    emit(CollectionLoaded(collections: collections, index: index));
  }

  void updateCollection(int index, Collection updatedCollection) {
    collections[index] = updatedCollection;
    emit(CollectionLoaded(collections: collections, index: this.index));
  }
}