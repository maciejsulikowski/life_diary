import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    String text,
  ) async {
    try {
      await _itemsRepository.add(title, imageURL, releaseDate, text);
      emit(
        const AddState(saved: true),
      );
    } catch (error) {
      emit(AddState(errorMessage: error.toString()));
    }
  }
}
