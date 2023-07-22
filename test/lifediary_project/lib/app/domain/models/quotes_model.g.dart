// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuotesModel _$QuotesModelFromJson(Map<String, dynamic> json) => QuotesModel(
      id: json['id'] as int,
      content: json['content'] as String,
      authorName: json['author_name'] as String,
      authorID: json['author_id'] as int,
    );

Map<String, dynamic> _$QuotesModelToJson(QuotesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'author_name': instance.authorName,
      'author_id': instance.authorID,
    };
