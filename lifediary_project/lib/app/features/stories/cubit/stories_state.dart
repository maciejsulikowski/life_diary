
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/stories_model.dart';

part 'stories_state.freezed.dart';

@freezed
class StoriesState with _$StoriesState {
  factory StoriesState(
    {@Default([]) List<StoriesModel> stories,
    @Default(Status.initial) Status status,
    String? errorMessage,}
  ) = _StoriesState;
}

// @immutable
// class StoriesState {
//   const StoriesState({
//     this.stories = const [],
//     this.status = Status.initial,
//     this.errorMessage,
//   });

//   final List<StoriesModel> stories;
//   final Status status;
//   final String? errorMessage;
// }
