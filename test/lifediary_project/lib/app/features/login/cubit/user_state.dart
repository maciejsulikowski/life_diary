part of 'user_cubit.dart';

@immutable
class UserState {
  final UserModel? userModel;
  final bool isLoading;
  final bool isSaved;

  UserState({
    required this.userModel,
    required this.isLoading,
    required this.isSaved,
  });


}
