import 'package:dio/dio.dart';


class QuotesRemoteDioDataSource {
  Future<List<Map<String, dynamic>>?> getQuotes() async {
    final response = await Dio().get<List<dynamic>>(
        'https://my-json-server.typicode.com/maciejsulikowski/json-demo/quotes');
    final listDynamic = response.data;
    if (listDynamic == null) {
      return null;
    }
    return listDynamic.map((item) => item as Map<String, dynamic>).toList();
  }
}
