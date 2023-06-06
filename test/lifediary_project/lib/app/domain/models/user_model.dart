import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserModel {
  UserModel({
    required this.id,
    this.imageURL = '',
  });

  final String id;
  String? imageURL;
}
