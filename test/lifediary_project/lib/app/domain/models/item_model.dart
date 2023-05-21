import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemModel {
  ItemModel({
    required this.id,
    required this.title,
    required this.imageURL,
    required this.releaseDate,
    this.text = '',
    this.fontWeight = 0,
  });

  final String id;
  final String title;
  final String imageURL;
  final DateTime releaseDate;
  final String text;
  final int fontWeight;

  String daysLeft() {
    return releaseDate.difference(DateTime.now()).inDays.toString();
  }

  String releaseDateFormatted() {
    return DateFormat.yMMMEd().format(releaseDate);
  }
}








