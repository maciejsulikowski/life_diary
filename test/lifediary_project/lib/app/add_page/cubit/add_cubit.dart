import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifediary_project/app/home/diaries/diaries_page_content.dart';
import 'package:meta/meta.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit() : super(AddState());

  Future<void> add(
    String title,
    String imageURL,
    DateTime releaseDate,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('items').add({
        'title': title,
        'image_url': imageURL,
        'release_date': releaseDate,
      });
      emit(
        const AddState(saved: true),
      );
    } catch (error) {
      emit(AddState(errorMessage: error.toString()));
    }
  }
}
