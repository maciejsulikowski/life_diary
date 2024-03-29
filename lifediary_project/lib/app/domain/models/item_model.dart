import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'item_model.freezed.dart';

@freezed
class ItemModel with _$ItemModel {
  ItemModel._();
  factory ItemModel({
    required String id,
    required String title,
    required String imageURL,
    required DateTime releaseDate,
    required List<dynamic> text,
    quill.QuillController? textFormat,
  }) = _ItemModel;

  String daysLeft() {
     return releaseDate.difference(DateTime.now()).inDays.toString();
  }

   String releaseDateFormatted() {
     return DateFormat.yMMMEd().format(releaseDate);
   }
}

// class ItemModel {
//   ItemModel({
//     required this.id,
//     required this.title,
//     required this.imageURL,
//     required this.releaseDate,
//     required this.text,
//     this.fontWeight = 0,
//     this.textFormat,
//   });

//   final String id;
//   final String title;
//   final String imageURL;
//   final DateTime releaseDate;
//   final List<dynamic> text;
//   final int fontWeight;
//   final quill.QuillController? textFormat;

//   String daysLeft() {
//     return releaseDate.difference(DateTime.now()).inDays.toString();
//   }

//   String releaseDateFormatted() {
//     return DateFormat.yMMMEd().format(releaseDate);
//   }
// }
