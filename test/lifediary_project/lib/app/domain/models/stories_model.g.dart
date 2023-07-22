// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StoriesModel _$$_StoriesModelFromJson(Map<String, dynamic> json) =>
    _$_StoriesModel(
      json['author_id'] as int,
      json['bio'] as String,
      json['picture'] as String,
      json['source'] as String,
    );

Map<String, dynamic> _$$_StoriesModelToJson(_$_StoriesModel instance) =>
    <String, dynamic>{
      'author_id': instance.authorID,
      'bio': instance.bio,
      'picture': instance.picture,
      'source': instance.source,
    };
