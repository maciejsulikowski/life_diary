// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_QuotesModel _$$_QuotesModelFromJson(Map<String, dynamic> json) =>
    _$_QuotesModel(
      json['id'] as int,
      json['content'] as String,
      json['author_name'] as String,
      json['author_id'] as int,
    );

Map<String, dynamic> _$$_QuotesModelToJson(_$_QuotesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'author_name': instance.authorName,
      'author_id': instance.authorID,
    };
