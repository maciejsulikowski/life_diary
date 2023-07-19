import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StoriesModel {
  StoriesModel({
    required this.authorID,
    required this.bio,
    required this.picture,
    required this.source,
  });

  final int authorID;
  final String bio;
  final String picture;
  final String source;

  StoriesModel.fromJson(Map<String, dynamic> json)
      : authorID = json['author_id'],
        bio = json['bio'],
        picture = json['picture'],
        source = json['source'];
}
