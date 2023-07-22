import 'package:json_annotation/json_annotation.dart';

part 'quotes_model.g.dart';

@JsonSerializable()
class QuotesModel {
  QuotesModel({
    required this.id,
    required this.content,
    required this.authorName,
    required this.authorID,
  });

  final int id;
  final String content;
  @JsonKey(name: 'author_name')
  final String authorName;
  @JsonKey(name: 'author_id')
  final int authorID;

  factory QuotesModel.fromJson(Map<String, dynamic> json) =>
      _$QuotesModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuotesModelToJson(this);
  // QuotesModel.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       content = json['content'],
  //       authorName = json['author_name'],
  //       authorID = json['author_id'];
}
