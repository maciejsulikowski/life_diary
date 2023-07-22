// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoriesModel _$StoriesModelFromJson(Map<String, dynamic> json) => StoriesModel(
      authorID: json['author_id'] as int,
      bio: json['bio'] as String,
      picture: json['picture'] as String,
      source: json['source'] as String,
    );

Map<String, dynamic> _$StoriesModelToJson(StoriesModel instance) =>
    <String, dynamic>{
      'author_id': instance.authorID,
      'bio': instance.bio,
      'picture': instance.picture,
      'source': instance.source,
    };
