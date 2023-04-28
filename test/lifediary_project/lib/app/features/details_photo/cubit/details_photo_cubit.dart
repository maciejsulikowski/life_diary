import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'details_photo_state.dart';

class DetailsPhotoCubit extends Cubit<DetailsPhotoState> {
  DetailsPhotoCubit() : super(DetailsPhotoState());
}
