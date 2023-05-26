import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifediary_project/app/domain/models/daily_plan_model.dart';

import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/models/item_model_to_do_list.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';
import 'package:lifediary_project/app/domain/models/water_model.dart';
import 'package:lifediary_project/app/features/details_photo/pages/details_photo_page.dart';

class PhotosRepository {
  Stream<List<PhotosModel>> getPhotosStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('photos')
        .orderBy('release_date')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return PhotosModel(
            id: doc.id,
            title: doc['title'],
            imageURL: doc['image_url'],
            releaseDate: (doc['release_date'] as Timestamp).toDate(),
            height: doc['height'] ?? '',
            weight: doc['weight'] ?? '',
            goals: doc['goals'] ?? '',
          );
        },
      ).toList();
    });
  }

  Future<void> savePhotoData(
    String id,
    String weight,
    String height,
    String goals,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('photos')
        .doc(id)
        .set(
      {
        'weight': weight,
        'height': height,
        'goals': goals,
      },
      SetOptions(merge: true),
    );
  }

  Future<void> deletephoto({required String id}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('photos')
        .doc(id)
        .delete();
  }

  Future<PhotosModel> getphotos({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('photos')
        .doc(id)
        .get();
    return PhotosModel(
      id: doc.id,
      title: doc['title'],
      imageURL: doc['image_url'],
      releaseDate: (doc['release_date'] as Timestamp).toDate(),
      height: doc['height'],
      weight: doc['weight'],
      goals: doc['goals'],
    );
  }

  Future<void> addphoto(
    String title,
    String imageURL,
    DateTime releaseDate,
    String weight,
    String height,
    String goals,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('photos')
        .add({
      'title': title,
      'image_url': imageURL,
      'release_date': releaseDate,
      'weight': weight,
      'height': height,
      'goals': goals,
    });
  }
}