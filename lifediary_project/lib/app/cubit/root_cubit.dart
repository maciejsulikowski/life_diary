import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/cubit/root_state.dart';
import 'package:lifediary_project/app/domain/repositories/root_repository.dart';
import 'package:lifediary_project/app/domain/repositories/user_repository.dart';

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

  Future<void> start() async {
    emit(
      RootState(
        user: null,
        status: Status.loading,
      ),
    );

    _streamSubscription = rootRepository.authStateChanges().listen((user) {
      emit(
        RootState(
          user: user,
          status: Status.success,
        ),
      );
    })
      ..onError((error) {
        emit(
          RootState(
            status: Status.error,
            user: null,
            errorMessage: error.toString(),
          ),
        );
      });
  }

  Future<void> createAccount(
    TextEditingController email,
    TextEditingController password,
  ) async {
    emit(RootState(
      status: Status.loading,
    ));
    try {
      await rootRepository.createAccount(
        email: email.text,
        password: password.text,
      );
      emit(RootState(
        status: Status.success,
      ));
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      switch (e.code) {
        case "invalid-email":
          errorMessage = 'Niepoprawny format adresu email.';
          break;
        case "email-already-in-use":
          errorMessage = 'Konto z tym adresem email już istnieje.';
          break;
        case "operation-not-allowed":
          errorMessage = 'Rejestracja z tym adresem email jest wyłączona.';
          break;
        case "weak-password":
          errorMessage = 'Hasło jest zbyt słabe.';
          break;
        default:
          errorMessage = 'Wystąpił błąd podczas rejestracji.';
          break;
      }

      emit(RootState(
        status: Status.error,
        errorMessage: errorMessage,
      ));
    }
  }

  Future<void> signIn(
    TextEditingController email,
    TextEditingController password,
  ) async {
    emit(RootState(
      status: Status.loading,
    ));
    try {
      await rootRepository.signIn(
        email: email.text,
        password: password.text,
      );
      emit(RootState(
        status: Status.success,
      ));
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      switch (e.code) {
        case "invalid-email":
          errorMessage = 'Niepoprawny format adresu email.';
          break;
        case "user-not-found":
          errorMessage = 'Brak użytkownika o podanym adresie email.';
          break;
        case "wrong-password":
          errorMessage = 'Niepoprawne hasło.';
          break;
        case "account-exists-with-different-credential":
          errorMessage = 'Konto już istnieje.';
          break;
        case "user-disabled":
          errorMessage = 'Użytkownik jest wyłączony.';
          break;
        default:
          errorMessage = 'Wystąpił błąd logowania.';
          break;
      }
      emit(RootState(
        errorMessage: errorMessage,
        status: Status.error,
      ));
    }
  }

  Future<void> signOut() async {
    await rootRepository.signOut();
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
