import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';
import 'package:powtoreczka/app/models/item_model.dart';

part 'all_things_state.dart';

class AllThingsCubit extends Cubit<AllThingsState> {
  AllThingsCubit()
      : super(
          AllThingsState(
            documents: [],
            isLoading: false,
            errorMessage: '',
          ),
        );

  Future<void> start() async {
    emit(
      AllThingsState(
        documents: [],
        isLoading: true,
        errorMessage: '',
      ),
    );

    
  }
}
