import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:minimalist_api_tester/db/database.dart';

import '../models/collection.dart';

part 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  CollectionCubit() : super(CollectionInitial());
  List<Collection> collections = [];
  int index = 0;
  final AppDatabase database = AppDatabase();

  void addNewCollection() {
    emit(CollectionLoading());
    try {
      collections.add(
        Collection(
          name: 'New Request',
          id: -1,
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

  void deleteCollection(int index) {
    collections.removeAt(index);
    if (this.index >= collections.length) {
      this.index = collections.length - 1;
    }
    if(this.index == index) {
      this.index = 0;
    }
    if(this.index < 0) {
      this.index = 0;
    }
    emit(CollectionLoaded(collections: collections, index: this.index));
  }

  void saveRequest(Collection collection) async {
    const JsonEncoder encoder = JsonEncoder.withIndent('    ');
    String headers = encoder.convert(collection.headers ?? {});
    String body = encoder.convert(collection.body ?? {});
    String expected = encoder.convert(collection.expected ?? {});
    String automation = encoder.convert(collection.automation ?? {});
    if(collection.id < 0) {
      await database.into(database.requests).insert(
        RequestsCompanion(
          name: Value(collection.name),
          url: Value(collection.url ?? ''),
          method: Value(collection.method),
          body: Value(body),
          expectedResponse: Value(expected),
          automation: Value(automation),
          authToken: Value(collection.authToken),
          headers: Value(headers),
          count: Value(collection.count),
          jsonOn: Value(collection.jsonOn),
          authOn: Value(collection.authOn),
          expectedOn: Value(collection.expectedOn),
          automationOn: Value(collection.automationOn),
          createdAt: Value(DateTime.now()),
        ),
      );
    } else {
      await database.managers.requests.filter((f) => f.id.equals(collection.id)).update((r) => r(
        name: Value(collection.name),
        url: Value(collection.url ?? ''),
        method: Value(collection.method),
        body: Value(body),
        expectedResponse: Value(expected),
        automation: Value(automation),
        authToken: Value(collection.authToken),
        headers: Value(headers),
        count: Value(collection.count),
        jsonOn: Value(collection.jsonOn),
        authOn: Value(collection.authOn),
        expectedOn: Value(collection.expectedOn),
        automationOn: Value(collection.automationOn),
      )
      );
    }
    fetchSavedRequests();
  }

  void fetchSavedRequests() async {
    final response = await database.managers.requests.get();
    JsonEncoder encoder = JsonEncoder.withIndent('  ');
    String output = encoder.convert(response);
    print(output);
  }
}