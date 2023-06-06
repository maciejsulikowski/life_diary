import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifediary_project/app/domain/models/daily_plan_model.dart';

import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/models/item_model_to_do_list.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';
import 'package:lifediary_project/app/domain/models/user_model.dart';
import 'package:lifediary_project/app/domain/models/water_model.dart';
import 'package:lifediary_project/app/features/details_photo/pages/details_photo_page.dart';

class UserRepository {
  Stream<UserModel?> getUserStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('users_photo')
        .doc(userID)
        .snapshots()
        .map((docSnapshot) {
      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        return UserModel(
          id: docSnapshot.id,
          imageURL: data?['image_url'],
        );
      } else {
        return null;
      }
    });
  }

  Future<void> add(
    String imageURL,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('users_photo')
        .doc(userID)
        .set(
      {
        'image_url': imageURL,
      },
      SetOptions(merge: true),
    );
  }

  Future<UserModel?> getUserPhoto(String imageURL) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('users_photo')
        .doc(userID)
        .get();
    if (doc.exists) {
      final data = doc.data();
      return UserModel(
        id: doc.id,
        imageURL: data?['image_url'],
      );
    } else {
      return null;
    }
  }
}
