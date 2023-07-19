import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QuotesModel {
  QuotesModel({
    required this.id,
    required this.content,
    required this.authorName,
    required this.authorID,
  });

  final int id;
  final String content;
  final String authorName;
  final int authorID;

  QuotesModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        authorName = json['author_name'],
        authorID = json['author_id'];
}
