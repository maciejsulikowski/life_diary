import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:powtoreczka/app/repositories/items_repository.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit(this._itemsRepository)
      : super(
          AddState(
            saved: false,
            errorMessage: '',
          ),
        );

  ItemsRepository _itemsRepository;

  Future<void> addPizza(
    String restaurantName,
    String pizzaName,
    double rating,
    DateTime release_date,
  ) async {
    try {
      _itemsRepository.add(
          restaurantName: restaurantName,
          pizzaName: pizzaName,
          rating: rating,
          release_date: release_date);
      emit(
        AddState(saved: true, errorMessage: ''),
      );
    } catch (error) {
      emit(
        AddState(
          saved: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
