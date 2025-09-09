import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

part 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  CollectionCubit() : super(CollectionInitial());
}