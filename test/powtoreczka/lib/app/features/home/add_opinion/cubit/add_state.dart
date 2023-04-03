part of 'add_cubit.dart';

@immutable
class AddState {
  final bool saved;
  final String errorMessage;

  const AddState({
    required this.saved,
    required this.errorMessage,
  });
}
