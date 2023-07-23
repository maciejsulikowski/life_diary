import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lifediary_project/app/core/enums.dart';
import 'package:lifediary_project/app/domain/models/stories_model.dart';
import 'package:lifediary_project/app/domain/repositories/stories_repository.dart';
import 'package:lifediary_project/app/features/stories/cubit/stories_state.dart';


class StoriesCubit extends Cubit<StoriesState> {
  StoriesCubit(this.storiesRepository) : super(StoriesState());

  final StoriesRepository storiesRepository;

  Future<void> fetchData({required int authorID}) async {
    emit(
      StoriesState(
        status: Status.loading,
      ),
    );
    try {
      final data = await storiesRepository.getStoriesModel(authorID);
      emit(
        StoriesState(
          stories: data,
          status: Status.success,
        ),
      );
    } catch (error) {
      emit(
        StoriesState(
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
