import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'photos_model.freezed.dart';

@freezed
class PhotosModel with _$PhotosModel {
  PhotosModel._();
  factory PhotosModel({
    required String id,
    required String title,
    required String imageURL,
    required DateTime releaseDate,
    @Default('') String weight,
    @Default('') String height,
    @Default('') String goals,
  }) = _PhotosModel;

String releaseDateFormatted() {
    return DateFormat.yMMMEd().format(releaseDate);
  }

}

// class PhotosModel {
//   PhotosModel({
//     required this.id,
//     required this.title,
//     required this.imageURL,
//     required this.releaseDate,
//     this.weight = '',
//     this.height = '',
//     this.goals = '',
//   });

//   final String id;
//   final String title;
//   final String imageURL;
//   final DateTime releaseDate;
//   final String weight;
//   final String height;
//   final String goals;

//   String releaseDateFormatted() {
//     return DateFormat.yMMMEd().format(releaseDate);
//   }
// }
