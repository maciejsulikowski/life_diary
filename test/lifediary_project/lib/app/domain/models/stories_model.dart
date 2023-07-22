import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stories_model.freezed.dart';
part 'stories_model.g.dart';

@freezed
class StoriesModel with _$StoriesModel {
  factory StoriesModel(
    @JsonKey(name: 'author_id') int authorID,
    String bio,
    String picture,
    String source,
  ) = _StoriesModel;

  factory StoriesModel.fromJson(Map<String, dynamic> json) =>
      _$StoriesModelFromJson(json);
}

// @JsonSerializable()
// class StoriesModel {
//   StoriesModel({
//     required this.authorID,
//     required this.bio,
//     required this.picture,
//     required this.source,
//   });

//   @JsonKey(name: 'author_id')
//   final int authorID;
//   final String bio;
//   final String picture;
//   final String source;

//   factory StoriesModel.fromJson(Map<String, dynamic> json) =>
//       _$StoriesModelFromJson(json);

//   Map<String, dynamic> toJson() => _$StoriesModelToJson(this);

  // StoriesModel.fromJson(Map<String, dynamic> json)
  //     : authorID = json['author_id'],
  //       bio = json['bio'],
  //       picture = json['picture'],
  //       source = json['source'];

