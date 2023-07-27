import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:injectable/injectable.dart';




@injectable
class ItemsRemoteDataSource {
  Stream<List<Map<String, dynamic>>> getItemsData() {
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
      final dataList = <Map<String, dynamic>>[];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        data['id'] = doc.id;
        dataList.add(data);
      }
      return dataList;
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

  Future<Map<String, dynamic>> get({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
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

   Future<void> add(
    String title,
    String imageURL,
    DateTime releaseDate,
    Delta text,
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
      'text': text.toJson(),
    });
  }

  Future<void> addtext(
    String id,
    Delta text,
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
        'text': text.toJson(),
      },
      SetOptions(merge: true),
    );
  }

  Future<Reference> pathRef() async {
    return FirebaseStorage.instance.ref();
  }
}
