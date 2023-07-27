import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model_to_do_list.freezed.dart';

@freezed
class ItemModelToDoList with _$ItemModelToDoList {
  factory ItemModelToDoList({
    required String id,
    required String title,
    @Default(false) bool isChecked,
  }) = _ItemModelToDoList;

  
}


// class ItemModelToDoList {
//   ItemModelToDoList({
//     required this.id,
//     required this.title,
//     this.isChecked = false,
//   });

//   final String id;
//   final String title;
//   bool isChecked;
// }
