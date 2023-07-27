import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:injectable/injectable.dart';
import 'package:lifediary_project/app/core/enums.dart';

import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:lifediary_project/app/features/add_page/cubit/add_state.dart';
import 'package:meta/meta.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit(this._itemsRepository) : super(AddState());

  final ItemsRepository _itemsRepository;

  Future<void> add(
    String title,
    String imageURL,
    DateTime releaseDate,
    Delta text,
    int fontWeight,
  ) async {
    try {
      await _itemsRepository.add(
          title, imageURL, releaseDate, text, fontWeight);
      emit(
        AddState(status: Status.success, isSaved: true),
      );
    } catch (error) {
      emit(AddState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<Reference> pathRef() async {
    return await _itemsRepository.pathRef();
  }
}
