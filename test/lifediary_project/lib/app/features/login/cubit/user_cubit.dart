import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lifediary_project/app/domain/models/user_model.dart';
import 'package:lifediary_project/app/domain/repositories/user_repository.dart';
import 'package:lifediary_project/app/features/login/user_profile.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._userRepository)
      : super(UserState(
          userModel: null,
          isLoading: false,
          isSaved: false,
        ));

  final UserRepository _userRepository;
  

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = _userRepository.getUserStream().listen(
      (userModel) {
        emit(
          UserState(userModel: userModel, isLoading: false, isSaved: false),
        );
      },
    );
  }

  Future<void> add(
    String imageURL,
  ) async {
    try {
      await _userRepository.add(imageURL);
      emit(UserState(userModel: null, isLoading: false, isSaved: true));
    } catch (error) {}
  }

   Future<void> addFullName(
    String fullName,
  ) async {
    try {
      await _userRepository.addFullName(fullName);
      emit(UserState(userModel: null, isLoading: false, isSaved: true));
    } catch (error) {}
  }

  Future<void> addStoryText(
    String storyText,
  ) async {
    try {
      await _userRepository.addStoryText(storyText);
      emit(UserState(userModel: null, isLoading: false, isSaved: true));
    } catch (error) {}
  }

  

  

  

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
