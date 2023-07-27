import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lifediary_project/app/data/remote_data_sources/user_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/daily_plan_model.dart';

import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/models/item_model_to_do_list.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';
import 'package:lifediary_project/app/domain/models/user_model.dart';
import 'package:lifediary_project/app/domain/models/water_model.dart';
import 'package:lifediary_project/app/features/details_photo/pages/details_photo_page.dart';

class UserRepository {
  UserRepository(this._userRemoteDataSource);

  final UserRemoteDataSource _userRemoteDataSource;

  Stream<UserModel?> getUserData() {
    return _userRemoteDataSource.getUserStream().map(
          (data) => UserModel(
            id: data['id'],
            imageURL: data['image_url'],
            fullName: data['full_name'],
            storyText: data['story_text'],
          ),
        );
  }

  Future<void> add(String imageURL) async {
    return _userRemoteDataSource.add(imageURL);
  }

  Future<void> addFullName(String fullName) async {
    return _userRemoteDataSource.addFullName(fullName);
  }

  Future<void> addStoryText(String storyText) async {
    return _userRemoteDataSource.addStoryText(storyText);
  }

  Future<Reference> pathRef() async {
    return _userRemoteDataSource.pathRef();
  }
}
