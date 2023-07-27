import 'package:lifediary_project/app/data/remote_data_sources/water_remote_data_source.dart';
import 'package:lifediary_project/app/domain/models/water_model.dart';

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
