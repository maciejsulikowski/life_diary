import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemModelToDoList {
  ItemModelToDoList({
    required this.id,
    required this.title,
    this.isChecked = false,
  });

  final String id;
  final String title;
  bool isChecked;
}
