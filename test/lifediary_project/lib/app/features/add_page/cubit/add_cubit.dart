import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:lifediary_project/app/core/enums.dart';

import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:meta/meta.dart';

part 'add_state.dart';

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
        const AddState(status: Status.success,saved: true),
      );
    } catch (error) {
      emit(AddState(status: Status.error,errorMessage: error.toString(),));
    }
  }
}
