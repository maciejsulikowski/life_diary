import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:lifediary_project/app/data/remote_data_sources/tasks_remote_data_sources.dart';
import 'package:lifediary_project/app/domain/models/item_model_to_do_list.dart';
import 'package:lifediary_project/app/domain/repositories/tasks_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockTasksDataSource extends Mock implements TasksRemoteDataSource {}

void main() {
  late TasksRepository sut;
  late MockTasksDataSource dataSource;
  late ItemModelToDoList itemModel;

  setUp(() {
    dataSource = MockTasksDataSource();
    sut = TasksRepository(dataSource);
  });

  group("getTasksStream", () {
    final streamController = StreamController<List<Map<String, dynamic>>>();
    final taskData = [
      {
        'id': '1',
        'title': 'title',
        'isChecked': false,
      }
    ];

    test('should call _tasksRemoteDataSource.getTasksData() method', () {
      //1
      when(() => dataSource.getTasksData())
          .thenAnswer((_) => streamController.stream);
      //2
      sut.getTasksStream();
      //3
      verify(() => dataSource.getTasksData()).called(1);
    });
    test('should return getTasksData() method successful', () {
      //1
      when(() => dataSource.getTasksData())
          .thenAnswer((_) => streamController.stream);
      //2
      final result = sut.getTasksStream();
      //3
      expectLater(
        result,
        emits([
          ItemModelToDoList(
            id: '1',
            title: 'title',
            isChecked: false,
          ),
        ]),
      );
      //4
      streamController.add(taskData);
      //5
      streamController.close();
    });
  });

  group('updateTask', () {
    final itemModel =
        ItemModelToDoList(id: '1', title: 'title', isChecked: false);

    test('should call _tasksRemoteDataSource.updateTask() method', () async {
      when(() => dataSource.updateTask(itemModel))
          .thenAnswer((_) async => [itemModel]);
      //2
      final results = await sut.updateTask(itemModel);
      //3
      verify(() => dataSource.updateTask(itemModel)).called(1);
    });
    test('should return updateTask() method successful', () async {
      when(() => dataSource.updateTask(itemModel))
          .thenAnswer((_) async => [itemModel]);
      final results = await sut.updateTask(itemModel);

      expect(results, [itemModel]);
    });
  });

  group('deletetask', () {
    const taskID = '1';
    final itemModel =
        ItemModelToDoList(id: '1', title: 'title', isChecked: false);

    test('should call _tasksRemoteDataSource.deletetask() method', () async {
      when(() => dataSource.deletetask(id: taskID)).thenAnswer((_) async => []);
      //2
      await sut.deletetask(id: taskID);
      //3
      verify(() => dataSource.deletetask(id: taskID)).called(1);
    });
    test('should return deletetask() method successful', () async {
      when(() => dataSource.deletetask(id: taskID))
          .thenAnswer((_) async => [itemModel]);
      final results = await sut.deletetask(id: taskID);

      expect(results, [itemModel]);
    });
  });

  group('gettasks', () {
    String taskId = '1';
    String taskTitle = 'title';
    final itemModel =
        ItemModelToDoList(id: '1', title: 'title', isChecked: false);
    test('should call _tasksRemoteDataSource.gettask() method', () async {
      //1
      when(() => dataSource.gettasks(id: taskId, title: taskTitle))
          .thenAnswer((_) async => {
                'id': taskId,
                'title': taskTitle,
                'isChecked': false,
              });
      //2
      await sut.gettasks(id: taskId, title: taskTitle);
      //3
      verify(() => dataSource.gettasks(id: taskId, title: taskTitle)).called(1);
    });

    test('should return gettasks() method successful ', () async {
      //1
      when(() => dataSource.gettasks(id: taskId, title: taskTitle))
          .thenAnswer((_) async => {
                'id': taskId,
                'title': taskTitle,
                'isChecked': false,
              });
      //2
      final result = await sut.gettasks(id: taskId, title: taskTitle);
      //3
      expect(
          result, ItemModelToDoList(id: '1', title: 'title', isChecked: false));
    });
  });

  group('addtask', () {
    const String title = 'title';
    bool isChecked = false;
    final itemModel =
        ItemModelToDoList(id: '1', title: 'title', isChecked: false);

    test('should call _tasksRemoteDataSource.addtask() method', () async {
      when(() => dataSource.addtask(title, isChecked))
          .thenAnswer((_) async => []);
      //2
      await sut.addtask(title, isChecked);
      //3
      verify(() => dataSource.addtask(title, isChecked)).called(1);
    });
    test('should return addtask() method successful', () async {
      when(() => dataSource.addtask(title, isChecked))
          .thenAnswer((_) async => [itemModel]);
      final results = await sut.addtask(title, isChecked);

      expect(results, [itemModel]);
    });
  });
}
