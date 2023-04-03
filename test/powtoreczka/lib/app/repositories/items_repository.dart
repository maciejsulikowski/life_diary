import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:powtoreczka/app/models/item_model.dart';

class ItemsRepository {
  Stream<List<ItemModel>> getItemsStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('restaurants')
        .orderBy('rating', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((document) {
        return ItemModel(
          id: document.id,
          name: document['name'],
          pizza: document['pizza'],
          rating: (document['rating']).toDouble(),
          releaseDate: (document['release_date'] as Timestamp).toDate(),
        );
      }).toList();
    });
  }

  Future<void> delete({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('restaurants')
        .doc(id)
        .delete();
  }

  Future<ItemModel> get({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final document = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('restaurants')
        .doc(id)
        .get();
    return ItemModel(
      id: document.id,
      name: document['name'],
      pizza: document['pizza'],
      rating: document['rating'],
      releaseDate: (document['release_date'] as Timestamp).toDate(),
    );
  }

  Future<void> add({
    required String restaurantName,
    required String pizzaName,
    required double rating,
    required DateTime release_date,
  }) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('restaurants')
        .add(
      {
        'name': restaurantName,
        'pizza': pizzaName,
        'rating': rating,
        'release_date': release_date,
      },
    );
  }
}
