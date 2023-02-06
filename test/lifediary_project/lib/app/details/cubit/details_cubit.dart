import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lifediary_project/app/models/item_model.dart';
import 'package:lifediary_project/app/repositories/items_repository.dart';
import 'package:meta/meta.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(
    this._itemsRepository,
  ) : super(DetailsState(
            itemModel: null, isLoading: false, errorMessage: '', saved: false));

  final ItemsRepository _itemsRepository;

  StreamSubscription? _streamSubscription;

  Future<void> getItemWithID(String id) async {
    final itemModel = await _itemsRepository.get(id: id);
    emit(
      DetailsState(
          itemModel: itemModel,
          isLoading: false,
          errorMessage: '',
          saved: false),
    );
  }

  Future<void> start() async {
    _streamSubscription = _itemsRepository.getItemsStream().listen(
      (itemModel) {
        emit(DetailsState(
            itemModel: null, isLoading: false, errorMessage: '', saved: false));
      },
    );

    // Future<void> addtext(
    //   String title,
    // ) async {
    //   await _itemsRepository.addtext(title);
    //   emit(
    //     DetailsState(
    //         itemModel: null, isLoading: true, errorMessage: '', saved: true),
    //   );
    // }

    // emit(DetailsState(
    //     itemModel: null, isLoading: false, errorMessage: '', saved: false));
  }

  Future<void> addtext(
    String id,
    String title,
  ) async {
    await _itemsRepository.addtext(id, title);
    final itemModel = await _itemsRepository.get(id: id);
    emit(
      DetailsState(
          itemModel: null, isLoading: true, errorMessage: '', saved: true),
    );
    emit(
      DetailsState(
          itemModel: itemModel,
          isLoading: false,
          errorMessage: '',
          saved: true),
    );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
