part of 'diares_cubit.dart';

@immutable
class DiaresState {
  DiaresState({
    this.items,
    this.loadingErrorOccured = false,
    this.removingErrorOccured = false,
  });
  final QuerySnapshot<Map<String, dynamic>>? items;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;
}
