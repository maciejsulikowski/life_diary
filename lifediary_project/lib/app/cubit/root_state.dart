part of 'root_cubit.dart';

@immutable
class RootState {
  final User? user;
  final Status status;
  final String? errorMessage;

  RootState({
    required this.user,
    this.status = Status.initial,
    this.errorMessage,
  });
}
