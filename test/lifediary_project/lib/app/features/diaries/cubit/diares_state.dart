part of 'diares_cubit.dart';

@immutable
class DiaresState {
  DiaresState({
    this.items = const [],
    this.status = Status.initial,
    this.errorMessage = '',
  });
  final List<ItemModel> items;
  final Status status;
  final String? errorMessage;
}
