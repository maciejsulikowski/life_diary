import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';



@injectable
class UserRemoteDataSource {
  Stream<Map<String, dynamic>> getUserStream() {
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
        final data = docSnapshot.data() ?? {};
        data['id'] = docSnapshot.id;
        return data;
      } else {
        return {};
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

  Future<void> addFullName(
    String fullName,
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
        'full_name': fullName,
      },
      SetOptions(merge: true),
    );
  }

  Future<void> addStoryText(
    String storyText,
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
        'story_text': storyText,
      },
      SetOptions(merge: true),
    );
  }

  Future<Reference> pathRef() async {
    return FirebaseStorage.instance.ref();
  }
}
