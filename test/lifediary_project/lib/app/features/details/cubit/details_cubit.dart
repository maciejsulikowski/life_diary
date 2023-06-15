import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/repositories/items_repository.dart';
import 'package:meta/meta.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(
    this._itemsRepository,
  ) : super(const DetailsState(
          itemModel: null,
          status: Status.loading,
          errorMessage: '',
          saved: false,
        ));

  final ItemsRepository _itemsRepository;

  StreamSubscription? _streamSubscription;

  Future<void> getItemWithID(String id) async {
    final itemModel = await _itemsRepository.get(id: id);
    emit(
      DetailsState(
        itemModel: itemModel,
        status: Status.success,
        errorMessage: '',
        saved: false,
      ),
    );
  }

  Future<void> start() async {
    _streamSubscription = _itemsRepository.getItemsStream().listen(
      (itemModel) {
        emit(const DetailsState(
          itemModel: null,
          status: Status.success,
          errorMessage: '',
          saved: false,
        ));
      },
    )..onError((error) {
        emit(DetailsState(
            itemModel: null,
            saved: false,
            status: Status.error,
            errorMessage: error.toString()));
      });
  }

  Future<void> addtext(
    String id,
    Delta title,
  ) async {
    await _itemsRepository.addtext(id, title);
    final itemModel = await _itemsRepository.get(id: id);
    emit(
      DetailsState(
        itemModel: itemModel,
        status: Status.success,
        errorMessage: '',
        saved: true,
      ),
    );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
