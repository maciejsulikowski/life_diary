part of 'stories_cubit.dart';

@immutable
class StoriesState {
  const StoriesState({
    this.stories = const [],
    this.status = Status.initial,
    this.errorMessage,
  });

  final List<StoriesModel> stories;
  final Status status;
  final String? errorMessage;
}
