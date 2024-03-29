import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';



@injectable
class PlansRemoteDataSource {
  Stream<List<Map<String, dynamic>>> getDailyPlansData() {
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
      List<Map<String, dynamic>> dataList = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        data['id'] = doc.id;
        dataList.add(data);
      }
      return dataList;
    });
  }

  Future<Map<String, dynamic>> getplans({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('plans')
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

  Future<void> addplan(
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
}
