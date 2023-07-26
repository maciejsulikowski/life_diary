import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/user_model.dart';
import 'package:lifediary_project/app/domain/repositories/root_repository.dart';
import 'package:lifediary_project/app/domain/repositories/user_repository.dart';
import 'package:lifediary_project/app/features/login/login_page.dart';

import 'package:meta/meta.dart';

part 'root_state.dart';

@injectable
class RootCubit extends Cubit<RootState> {
  RootCubit(this.userRepository, this.rootRepository)
      : super(
          RootState(
            user: null,
            status: Status.loading,
          ),
        );

  StreamSubscription? _streamSubscription;

  final UserRepository userRepository;
  final RootRepository rootRepository;

  Future<void> createAccount(
    TextEditingController email,
    TextEditingController password,
  ) async {
    try {
      await rootRepository.createAccount(
        email: email.text,
        password: password.text,
      );
    } catch (error) {
      emit(
        RootState(
          user: null,
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> signIn(
    TextEditingController email,
    TextEditingController password,
  ) async {
    try {
      await rootRepository.signIn(
        email: email.text,
        password: password.text,
      );
    } catch (error) {
      emit(
        RootState(
          user: null,
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> signOut() async {
    await rootRepository.signOut();
  }

  Future<void> start() async {
    emit(
      RootState(
        user: null,
        status: Status.loading,
        errorMessage: '',
      ),
    );

    _streamSubscription = rootRepository.authStateChanges().listen((user) {
      emit(
        RootState(
          user: user,
          status: Status.success,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          RootState(
            user: null,
            errorMessage: error.toString(),
          ),
        );
      });
  }

  Future<void> addUserPhoto(String imageURL) async {
    await userRepository.add(imageURL);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
