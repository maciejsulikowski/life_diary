import 'package:dio/dio.dart';

class StoriesRemoteDioDataSource {
  Future<List<Map<String, dynamic>>?> getStories() async {
    final response = await Dio().get<List<dynamic>>(
        'https://my-json-server.typicode.com/maciejsulikowski/json-demo/stories');
    final listDynamic = response.data;
    if (listDynamic == null) {
      return null;
    }
    return listDynamic.map((item) => item as Map<String, dynamic>).toList();
  }
}
