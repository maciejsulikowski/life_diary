import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifediary_project/app/domain/models/user_model.dart';
import 'package:lifediary_project/app/domain/repositories/user_repository.dart';
import 'package:lifediary_project/app/features/login/login_page.dart';

import 'package:meta/meta.dart';

part 'root_state.dart';

class RootCubit extends Cubit<RootState> {
  RootCubit(this._userRepository)
      : super(
          RootState(
            user: null,
            isLoading: false,
            errorMessage: '',
          ),
        );

  StreamSubscription? _streamSubscription;

  final UserRepository _userRepository;

  Future<void> createAccount(
    TextEditingController email,
    TextEditingController password,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
    } catch (error) {
      emit(
        RootState(
          user: null,
          isLoading: false,
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
    } catch (error) {
      emit(
        RootState(
          user: null,
          isLoading: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    
  }

  Future<void> start() async {
    emit(
      RootState(
        user: null,
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamSubscription =
        FirebaseAuth.instance.authStateChanges().listen((user) {
      emit(
        RootState(
          user: user,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
          ..onError((error) {
            emit(
              RootState(
                user: null,
                isLoading: false,
                errorMessage: error.toString(),
              ),
            );
          });
  }

  Future<void> addUserPhoto(String imageURL) async {
    await _userRepository.add(imageURL);
    
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
