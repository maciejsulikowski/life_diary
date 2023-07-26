import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lifediary_project/app/data/remote_data_sources/photos_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/daily_plan_model.dart';

import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/models/item_model_to_do_list.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';
import 'package:lifediary_project/app/domain/models/water_model.dart';
import 'package:lifediary_project/app/features/details_photo/pages/details_photo_page.dart';



@injectable
class PhotosRepository {
  PhotosRepository(this._photosRemoteDataSource);

  final PhotosRemoteDataSource _photosRemoteDataSource;

  Stream<List<PhotosModel>> getPhotosStream() {
    return _photosRemoteDataSource.getPhotosData().map((dataList) {
      return dataList
          .map((data) => PhotosModel(
                id: data['id'],
                title: data['title'],
                imageURL: data['image_url'],
                releaseDate: (data['release_date'] as Timestamp).toDate(),
                height: data['height'] ?? '',
                weight: data['weight'] ?? '',
                goals: data['goals'] ?? '',
              ))
          .toList();
    });
  }

  Future<void> savePhotoData(
    String id,
    String weight,
    String height,
    String goals,
  ) async {
    return _photosRemoteDataSource.savePhotoData(id, weight, height, goals);
  }

  Future<void> deletephoto({required String id}) {
    return _photosRemoteDataSource.deletephoto(id: id);
  }

  Future<PhotosModel> getphotos({required String id}) async {
    final data = await _photosRemoteDataSource.getphotos(id: id);
    return PhotosModel(
      id: data['id'],
      title: data['title'],
      imageURL: data['image_url'],
      releaseDate: (data['release_date'] as Timestamp).toDate(),
      height: data['height'],
      weight: data['weight'],
      goals: data['goals'],
    );
  }

  Future<void> addphoto(
    String title,
    String imageURL,
    DateTime releaseDate,
    String weight,
    String height,
    String goals,
  ) async {
    return _photosRemoteDataSource.addphoto(
        title, imageURL, releaseDate, weight, height, goals);
  }

  Future<Reference> pathRef() async {
    return await _photosRemoteDataSource.pathRef();
  }
}
