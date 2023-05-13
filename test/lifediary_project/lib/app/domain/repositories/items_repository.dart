import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/features/details_photo/pages/details_photo_page.dart';

class ItemsRepository {
  Stream<List<ItemModel>> getItemsStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .orderBy('release_date')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return ItemModel(
            id: doc.id,
            title: doc['title'],
            imageURL: doc['image_url'],
            releaseDate: (doc['release_date'] as Timestamp).toDate(),
            text: doc['text'],
          );
        },
      ).toList();
    });
  }

  Stream<List<DailyPlanModel>> getDailyPlansStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('plans')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return DailyPlanModel(
            id: doc.id,
            text: doc['title'],
            time: doc['time'],
          );
        },
      ).toList();
    });
  }

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

  Stream<List<ItemModelToDoList>> getTasksStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tasks')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return ItemModelToDoList(
            id: doc.id,
            title: doc['task'],
          );
        },
      ).toList();
    });
  }

  Stream<WaterModel?> getGlassesStream() {
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
        final data = docSnapshot.data();
        return WaterModel(
          id: docSnapshot.id,
          glasses: data?['glasses'] ?? '?',
        );
      } else {
        return null;
      }
    });
  }

  Future<void> saveGlasses(String glasses) async {
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

  Future<void> delete({required String id}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .doc(id)
        .delete();
  }

  Future<void> deletetask({required String id}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tasks')
        .doc(id)
        .delete();
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

  Future<ItemModel> get({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .doc(id)
        .get();
    return ItemModel(
      id: doc.id,
      title: doc['title'],
      imageURL: doc['image_url'],
      releaseDate: (doc['release_date'] as Timestamp).toDate(),
      text: doc['text'],
      fontWeight: doc['font_weight'] ?? 0,
    );
  }

  Future<ItemModelToDoList> gettasks(
      {required String id, required String title}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tasks')
        .doc(id)
        .get();
    return ItemModelToDoList(
      id: doc.id,
      title: doc['title'],
    );
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

  Future<DailyPlanModel> getplans({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('plans')
        .doc(id)
        .get();
    return DailyPlanModel(
      id: doc.id,
      text: doc['plan'],
      time: doc['time'],
    );
  }

  Future<WaterModel> getGlasses({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('water_glasses')
        .doc(id)
        .get();
    return WaterModel(
      id: doc.id,
      glasses: doc['glasses'] ?? '?',
    );
  }

  Future<void> add(
    String title,
    String imageURL,
    DateTime releaseDate,
    String text,
    int fontWeight,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .add({
      'title': title,
      'image_url': imageURL,
      'release_date': releaseDate,
      'text': text,
      'font_weight': fontWeight,
    });
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

  Future<void> addtask(
    String title,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tasks')
        .add({
      'task': title,
    });
  }

  Future<void> addplan(
    // String id,
    String text,
    String time,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('plans')
        .doc(time)
        .set(
      {
        'title': text,
        'time': time,
      },
      SetOptions(merge: true),
    );
  }

  Future<void> addtext(
    String id,
    String text,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .doc(id)
        .set(
      {
        'text': text,
      },
      SetOptions(merge: true),
    );
  }
}
