import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:lifediary_project/app/data/remote_data_sources/items_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/item_model.dart';

class ItemsRepository {
  ItemsRepository(this._itemsRemoteDataSource);
  final ItemsRemoteDataSource _itemsRemoteDataSource;

  Stream<List<ItemModel>> getItemsStream() {
    return _itemsRemoteDataSource.getItemsData().map((dataList) {
      return dataList
          .map((data) => ItemModel(
                id: data['id'],
                title: data['title'],
                imageURL: data['image_url'],
                releaseDate: (data['release_date'] as Timestamp).toDate(),
                text: data['text'],
              ))
          .toList();
    });
  }

  Future<void> delete({required String id}) {
    return _itemsRemoteDataSource.delete(id: id);
  }

  Future<ItemModel> get({required String id}) async {
    final data = await _itemsRemoteDataSource.get(id: id);
    return ItemModel(
      id: data['id'],
      title: data['title'],
      imageURL: data['image_url'],
      releaseDate: (data['release_date'] as Timestamp).toDate(),
      text: data['text'],
    );
  }

  Future<void> add(
    String title,
    String imageURL,
    DateTime releaseDate,
    Delta text,
    int fontWeight,
  ) async {
    return _itemsRemoteDataSource.add(
        title, imageURL, releaseDate, text, fontWeight);
  }

  Future<void> addtext(
    String id,
    Delta text,
  ) async {
    return _itemsRemoteDataSource.addtext(id, text);
  }

  Future<Reference> pathRef() async {
    return await _itemsRemoteDataSource.pathRef();
  }
}
