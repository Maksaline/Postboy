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

  void saveRequest(Collection collection, int collectionIndex, int reqId) async {
    const JsonEncoder encoder = JsonEncoder.withIndent('    ');
    String headers = encoder.convert(collection.headers ?? {});
    String body = encoder.convert(collection.body ?? {});
    String expected = encoder.convert(collection.expected ?? {});
    String automation = encoder.convert(collection.automation ?? {});
    if(collection.id < 0) {
      int id = await database.into(database.requests).insert(
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
      reqId = id;
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
    collections[collectionIndex] = Collection(
      id: reqId,
      name: collection.name,
      url: collection.url,
      method: collection.method,
      headers: collection.headers,
      body: collection.body,
      authToken: collection.authToken,
      automation: collection.automation,
      count: collection.count,
      expected: collection.expected,
      jsonOn: collection.jsonOn,
      authOn: collection.authOn,
      expectedOn: collection.expectedOn,
      automationOn: collection.automationOn,
    );
    emit(CollectionLoaded(collections: collections, index: index));
    // fetchSavedRequests();
  }

  void fetchSavedRequests() async {
    final response = await database.managers.requests.get();
    for(var req in response) {
      Map<String, String>? headers;
      Map<String, String>? body;
      Map<String, String>? expected;
      Map<String, Map<String, dynamic>>? automation;
      if(req.headers != null && req.headers!.isNotEmpty) {
        try {
          headers = Map<String, String>.from(jsonDecode(req.headers!));
        } catch(e) {
          headers = {};
        }
      }
      if(req.body != null && req.body!.isNotEmpty) {
        try {
          body = Map<String, String>.from(jsonDecode(req.body!));
        } catch(e) {
          body = {};
        }
      }
      if(req.expectedResponse != null && req.expectedResponse!.isNotEmpty) {
        try {
          expected = Map<String, String>.from(jsonDecode(req.expectedResponse!));
        } catch(e) {
          expected = {};
        }
      }
      if(req.automation != null && req.automation!.isNotEmpty) {
        try {
          automation = Map<String, Map<String, dynamic>>.from(jsonDecode(req.automation!));
        } catch(e) {
          automation = {};
        }
      }
      collections.add(
        Collection(
          id: req.id,
          name: req.name,
          url: req.url,
          method: req.method,
          headers: headers,
          body: body,
          authToken: req.authToken,
          automation: automation,
          count: req.count,
          expected: expected,
          jsonOn: req.jsonOn,
          authOn: req.authOn,
          expectedOn: req.expectedOn,
          automationOn: req.automationOn,
        )
      );
    }
    emit(CollectionLoaded(collections: collections, index: index));
  }

  void deleteSavedRequest(int id, int collectionIndex) async {
    await database.managers.requests.filter((f) => f.id.equals(id)).delete();
    deleteCollection(collectionIndex);
  }

  void unSaveRequest(int collectionIndex) async {
    if(collections[collectionIndex].id < 0) {
      return;
    }
    int deleted = await database.managers.requests.filter((f) => f.id.equals(collections[collectionIndex].id)).delete();
    if(deleted > 0) {
      collections[collectionIndex] = Collection(
      id: -1,
      name: collections[collectionIndex].name,
      url: collections[collectionIndex].url,
      method: collections[collectionIndex].method,
      headers: collections[collectionIndex].headers,
      body: collections[collectionIndex].body,
      authToken: collections[collectionIndex].authToken,
      automation: collections[collectionIndex].automation,
      count: collections[collectionIndex].count,
      expected: collections[collectionIndex].expected,
      jsonOn: collections[collectionIndex].jsonOn,
      authOn: collections[collectionIndex].authOn,
      expectedOn: collections[collectionIndex].expectedOn,
      automationOn: collections[collectionIndex].automationOn,
      );
    }
    emit(CollectionLoaded(collections: collections, index: index));
  }

  void saveFromList(int collectionIndex) async {
    if(collections[collectionIndex].id >= 0) {
      return;
    }
    int reqId = -1;
    saveRequest(collections[collectionIndex], collectionIndex, reqId);
  }
}