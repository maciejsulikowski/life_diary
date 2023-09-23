import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/data/remote_data_sources/plans_remote_data_sources.dart';
import 'package:lifediary_project/app/domain/models/daily_plan_model.dart';
import 'package:lifediary_project/app/domain/repositories/plans_repository.dart';
import 'package:lifediary_project/app/features/daily_plan/daily_plan_page_content.dart';
import 'package:mocktail/mocktail.dart';

class MockPlanDataSource extends Mock implements PlansRemoteDataSource {}

void main() {
  late MockPlanDataSource dataSource;
  late PlansRepository sut;

  setUp(() {
    dataSource = MockPlanDataSource();
    sut = PlansRepository(dataSource);
  });

  group('getDailyPlansStream', () {
    final streamController = StreamController<List<Map<String, dynamic>>>();
    final plansData = [
      {
        'id': '1',
        'title': 'text',
        'time': '600',
      }
    ];

    test('should call _plansRemoteDataSource.getDailyPlansData() method', () {
      //1
      when(() => dataSource.getDailyPlansData())
          .thenAnswer((_) => streamController.stream);
      //2
      sut.getDailyPlansStream();
      //3
      verify(() => dataSource.getDailyPlansData()).called(1);
    });

    test('should return getDailyPlanStream() method successful', () {
      //1
      when(() => dataSource.getDailyPlansData())
          .thenAnswer((_) => streamController.stream);
      //2
      final results = sut.getDailyPlansStream();
      //3
      expectLater(
        results,
        emits(
          [
            DailyPlanModel(
              id: '1',
              text: 'text',
              time: '600',
            ),
          ],
        ),
      );
      //4
      streamController.add(plansData);
      //5
      streamController.close();
    });
  });

  group('getplans', () {
    const String planID = '1';
    test('should call _plansRemoteDataSource.getplans() method ', () async {
      //1
      when(() => dataSource.getplans(id: planID)).thenAnswer((_) async => {
            'id': planID,
            'time': 'time',
            'text': 'text',
          });
      //2
      sut.getplans(id: planID);
      //3
      verify(() => dataSource.getplans(id: planID)).called(1);
    });

    test('should return getplans() method successful', () async {
      when(() => dataSource.getplans(id: planID)).thenAnswer((_) async => {
            'id': planID,
            'time': 'time',
            'text': 'text',
          });
      //2
      final result = await sut.getplans(id: planID);
      //3
      expect(result, DailyPlanModel(id: planID, time: 'time', text: 'text'));
    });
  });

  group('addplan', () {
    test('should call _plansRemoteDataSource.addplan() method', () async {
      //1
      when(() => dataSource.addplan('text', 'time'))
          .thenAnswer((_) async => []);
      //2
      await sut.addplan('text', 'time');
      //3
      verify(() => dataSource.addplan('text', 'time')).called(1);
    });
    test('should return addplan() method successful', () async {
      //1
      when(() => dataSource.addplan('text', 'time')).thenAnswer((_) async => [
            DailyPlanModel(id: '1', time: 'time'),
          ]);
      //2
      final results = await sut.addplan('text', 'time');
      //3
      expect(results, [
        DailyPlanModel(id: '1', time: 'time'),
      ]);
    });
  });
}
