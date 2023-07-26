import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lifediary_project/app/domain/models/daily_plan_model.dart';

import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/models/item_model_to_do_list.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';
import 'package:lifediary_project/app/domain/models/water_model.dart';
import 'package:lifediary_project/app/features/details_photo/pages/details_photo_page.dart';



@injectable
class WaterRemoteDataSource {
  Stream<Map<String, dynamic>> getGlassesData() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('water_glasses')
        .doc(userID)
        .snapshots()
        .map((docSnapshot) {
      if (docSnapshot.exists) {
        final data = docSnapshot.data() ?? {};
        data['id'] = docSnapshot.id;
        return data;
      } else {
        return {};
      }
    });
  }

  Future<void> saveGlassesData(String glasses) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('water_glasses')
        .doc(userID)
        .set(
      {
        'glasses': glasses,
      },
      SetOptions(merge: true),
    );
  }

  Future<Map<String, dynamic>> getGlasses({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('water_glasses')
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
}
