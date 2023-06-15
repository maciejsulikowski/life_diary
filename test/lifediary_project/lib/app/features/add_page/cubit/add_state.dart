part of 'add_cubit.dart';

@immutable
class AddState {
  const AddState({
    this.status = Status.initial,
    this.saved = false,
    this.errorMessage,
  });

  final Status status;
  final bool saved;
  final String? errorMessage;
}
