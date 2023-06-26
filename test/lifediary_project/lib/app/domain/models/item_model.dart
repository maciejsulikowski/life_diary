import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class ItemModel {
  ItemModel({
    required this.id,
    required this.title,
    required this.imageURL,
    required this.releaseDate,
    required this.text,
    this.fontWeight = 0,
    this.textFormat,
  });

  final String id;
  final String title;
  final String imageURL;
  final DateTime releaseDate;
  final List<dynamic> text;
  final int fontWeight;
  final quill.QuillController? textFormat;

  String daysLeft() {
    return releaseDate.difference(DateTime.now()).inDays.toString();
  }

  String releaseDateFormatted() {
    return DateFormat.yMMMEd().format(releaseDate);
  }
}
