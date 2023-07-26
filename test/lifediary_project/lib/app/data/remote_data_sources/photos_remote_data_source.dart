import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lifediary_project/app/domain/models/daily_plan_model.dart';

import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/models/item_model_to_do_list.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';
import 'package:lifediary_project/app/domain/models/water_model.dart';
import 'package:lifediary_project/app/features/details_photo/pages/details_photo_page.dart';



@injectable
class PhotosRemoteDataSource {
  Stream<List<Map<String, dynamic>>> getPhotosData() {
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
        .map((docSnapshot) {
      List<Map<String, dynamic>> dataList = [];
      for (var doc in docSnapshot.docs) {
        final data = doc.data();
        data['id'] = doc.id;
        dataList.add(data);
      }
      return dataList;
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

  Future<Map<String, dynamic>> getphotos({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('photos')
        .doc(id)
        .get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data() ?? {};
      data['id'] = docSnapshot.id;
      return data;
    } else {
      return {};
    }
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
  Future<Reference> pathRef() async {
    return FirebaseStorage.instance.ref();
  }
}
