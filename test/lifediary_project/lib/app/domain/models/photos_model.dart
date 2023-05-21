import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PhotosModel {
  PhotosModel({
    required this.id,
    required this.title,
    required this.imageURL,
    required this.releaseDate,
    this.weight = '',
    this.height = '',
    this.goals = '',
  });

  final String id;
  final String title;
  final String imageURL;
  final DateTime releaseDate;
  final String weight;
  final String height;
  final String goals;

  String releaseDateFormatted() {
    return DateFormat.yMMMEd().format(releaseDate);
  }
}
