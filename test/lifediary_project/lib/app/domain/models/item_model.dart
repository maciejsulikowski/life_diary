import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemModel {
  ItemModel({
    // required this.text,
    required this.id,
    required this.title,
    required this.imageURL,
    required this.releaseDate,
    required this.text,
  });

  final String id;
  final String title;
  final String imageURL;
  final DateTime releaseDate;
  String text = '';

  String daysLeft() {
    return releaseDate.difference(DateTime.now()).inDays.toString();
  }

  String releaseDateFormatted() {
    return DateFormat.yMMMEd().format(releaseDate);
  }
}

class ItemModelToDoList {
  ItemModelToDoList({
    required this.id,
    required this.title,
  });

  final String id;
  final String title;
}

class PhotosModel {
  PhotosModel({
    required this.id,
    required this.title,
    required this.imageURL,
    required this.releaseDate,
  });

  final String id;
  final String title;
  final String imageURL;
  final DateTime releaseDate;

  String releaseDateFormatted() {
    return DateFormat.yMMMEd().format(releaseDate);
  }
}

class DailyPlanModel {
  DailyPlanModel({
    required this.id,
    this.text = '',
    required this.time,
  });

  final String id;
  String text;
  final String time;
}
