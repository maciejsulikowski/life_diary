import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lifediary_project/app/data/remote_data_sources/water_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/daily_plan_model.dart';

import 'package:lifediary_project/app/domain/models/item_model.dart';
import 'package:lifediary_project/app/domain/models/item_model_to_do_list.dart';
import 'package:lifediary_project/app/domain/models/photos_model.dart';
import 'package:lifediary_project/app/domain/models/water_model.dart';
import 'package:lifediary_project/app/features/details_photo/pages/details_photo_page.dart';


@injectable
class WaterRepository {
  WaterRepository(this._waterRemoteDataSource);

  final WaterRemoteDataSource _waterRemoteDataSource;

  Stream<WaterModel?> getGlassesStream() {
    return _waterRemoteDataSource.getGlassesData().map((data) => WaterModel(
          id: data['id'],
          glasses: data['glasses'] ?? '?',
        ));
  }

  Future<void> saveGlasses(String glasses) async {
    return _waterRemoteDataSource.saveGlassesData(glasses);
  }

  Future<WaterModel> getGlasses({required String id}) async {
    final data = await _waterRemoteDataSource.getGlasses(id: id);
    return WaterModel(
      id: data['id'],
      glasses: data['glasses'] ?? '?',
    );
  }
}
