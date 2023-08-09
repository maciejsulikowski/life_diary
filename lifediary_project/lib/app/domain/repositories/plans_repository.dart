import 'package:lifediary_project/app/data/remote_data_sources/plans_remote_data_sources.dart';
import 'package:lifediary_project/app/domain/models/daily_plan_model.dart';

class PlansRepository {
  PlansRepository(this._plansRemoteDataSource);

  final PlansRemoteDataSource _plansRemoteDataSource;

  Stream<List<DailyPlanModel>> getDailyPlansStream() {
    return _plansRemoteDataSource.getDailyPlansData().map((data) {
      return data
          .map(
            (data) => DailyPlanModel(
              id: data['id'],
              time: data['time'],
              text: data['title'],
            ),
          )
          .toList();
    });
  }

  Future<DailyPlanModel> getplans({required String id}) async {
    final data = await _plansRemoteDataSource.getplans(id: id);
    return DailyPlanModel(
      id: data['id'],
      time: data['time'],
      text: data['text'],
    );
  }

  Future addplan(
    String text,
    String time,
  ) async {
    return _plansRemoteDataSource.addplan(text, time);
  }
}
