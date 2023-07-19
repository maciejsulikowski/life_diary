import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StoriesModel {
  StoriesModel({
    required this.authorID,
    required this.biography,
    required this.picture,
    required this.source,
  });

  final int authorID;
  final String biography;
  final String picture;
  final String source;
}
