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
      index = collections.length;
      collections.add(
        Collection(
          name: 'New Request',
          id: index,
          method: 'GET',
        )
      );
      emit(CollectionLoaded(collections: collections, index: index));
    } catch (e) {
      emit(CollectionFailure(message: e.toString()));
    }
  }
}