import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'user_model.freezed.dart';


@freezed
class UserModel with _$UserModel {
  factory UserModel({
    String? id,
    @Default('') String imageURL,
    @Default('') String fullName,
    @Default('') String storyText,}

  ) = _UserModel;


}

// class UserModel {
//   UserModel({
//     required this.id,
//     this.imageURL = '',
//     this.fullName = '',
//     this.storyText = '',
//   });

//   final String id;
//   String? imageURL;
//   String? fullName;
//   String? storyText;
// }
