import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lifediary_project/app/core/enums.dart';

part  'root_state.freezed.dart';


@freezed
class RootState with _$RootState {
  factory RootState({
    User? user,
    @Default(Status.initial) Status status,
    String? errorMessage,
    
  }) = _RootState;
}
