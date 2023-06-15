part of 'user_cubit.dart';

@immutable
class UserState {
  final UserModel? userModel;
  final Status status;
  final String errorMessage;
  final bool isSaved;

  UserState({
    required this.userModel,
    this.status = Status.initial,
    required this.isSaved,
    this.errorMessage = '',
  });
}
