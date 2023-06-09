import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserModel {
  UserModel({
    required this.id,
    this.imageURL = '',
    this.fullName = '',
  });

  final String id;
  String? imageURL;
  String? fullName;
}
