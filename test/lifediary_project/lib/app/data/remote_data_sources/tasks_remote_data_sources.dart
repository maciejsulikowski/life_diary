import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:lifediary_project/app/domain/models/item_model_to_do_list.dart';



@injectable
class TasksRemoteDataSource {
  Stream<List<Map<String, dynamic>>> getTasksData() {
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
      List<Map<String, dynamic>> dataList = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        data['id'] = doc.id;
        dataList.add(data);
      }
      return dataList;
    });
  }

  Future<void> updateTask(
    ItemModelToDoList itemModel,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tasks')
        .doc(itemModel.id)
        .set(
      {
        'isChecked': itemModel.isChecked,
      },
      SetOptions(merge: true),
    );
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

  Future<Map<String, dynamic>> gettasks(
      {required String id, required String title}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('tasks')
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

  Future<void> addtask(
    String title,
    bool isChecked,
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
      'title': title,
      'isChecked': isChecked,
    });
  }
}
