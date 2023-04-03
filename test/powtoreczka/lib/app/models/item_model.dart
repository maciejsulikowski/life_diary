import 'package:intl/intl.dart';

class ItemModel {
  ItemModel({
    required this.id,
    required this.name,
    required this.pizza,
    required this.rating,
    required this.releaseDate,
  });
  final String id;
  final String name;
  final String pizza;
  final double rating;
  final DateTime releaseDate;
}


