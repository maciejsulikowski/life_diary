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

  // final String text;
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

class ItemModelText {
  ItemModelText({
    required this.text,
  });

  final String text;
}
