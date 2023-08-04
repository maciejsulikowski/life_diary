import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/repositories/user_repository.dart';
import 'package:lifediary_project/app/features/login/cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._userRepository) : super(UserState());

  final UserRepository _userRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(UserState(
      status: Status.loading,
    ));
    _streamSubscription = _userRepository.getUserData().listen(
      (userModel) {
        try {
          emit(
            UserState(
                userModel: userModel, status: Status.success, isSaved: false),
          );
        } catch (error) {
          emit(
            UserState(
              status: Status.error,
              isSaved: false,
              errorMessage: error.toString(),
            ),
          );
        }
      },
    );
  }

  Future<void> add(
    String imageURL,
  ) async {
    try {
      await _userRepository.add(imageURL);
      emit(UserState(status: Status.success, isSaved: true));
    } catch (error) {
      emit(UserState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> addFullName(
    String fullName,
  ) async {
    try {
      await _userRepository.addFullName(fullName);
      emit(UserState(status: Status.success, isSaved: true));
    } catch (error) {
      emit(UserState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> addStoryText(
    String storyText,
  ) async {
    try {
      await _userRepository.addStoryText(storyText);
      emit(UserState(status: Status.success, isSaved: true));
    } catch (error) {
      emit(UserState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<Reference> pathRef() async {
    return await _userRepository.pathRef();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
