import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:lifediary_project/app/domain/models/item_model.dart';

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

  Future<void> add(
    String title,
    String imageURL,
    DateTime releaseDate,
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
        .add({
      'title': title,
      'image_url': imageURL,
      'release_date': releaseDate,
      'text': text,
    });
  }

  Future<void> addphoto(
    String title,
    String imageURL,
    DateTime releaseDate,
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
    // final docs = await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(userID)
    //     .collection('plans')
    //     .where('time', isEqualTo: time) // zwroci wszystkie dokumenty z time
    //     .get();

    // w zaleznosci od ilosci dokumentow wywolac update albo add
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

  // Future<void> getplan(
  //   String text,
  //   String time,
  // ) async {
  //   final userID = FirebaseAuth.instance.currentUser?.uid;
  //   if (userID == null) {
  //     throw Exception('User is not logged in');
  //   }
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userID)
  //       .collection('plans')
  //       .get(
  //     {
  //       'title': text,
  //       'time': time,
  //     },
  //   );
  // }

  // Future<void> updatePlan(String text, int index) async {
  //   final userID = FirebaseAuth.instance.currentUser?.uid;
  //   if (userID == null) {
  //     throw Exception('User is not logged in');
  //   }

  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userID)
  //       .collection('plans')
  //       .doc(index.toString())
  //       .update(
  //     {'plan': text},
  //   );
  // }

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