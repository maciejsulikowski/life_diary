import 'package:dio/dio.dart';

class QuotesRemoteDataSource {
  Future<List<Map<String, dynamic>>?> getQuotes() async {
    return [
      {
        "id": 1,
        "content":
            "Najlepszy sposób na przewidzenie przyszłości jest jej stworzenie.",
        "author_id": 1,
        "author_name": "Henry Ford"
      },
      {
        "id": 2,
        "content":
            "Twoje życie zmieni się dopiero wtedy, gdy zaczniesz zmieniać się sam.",
        "author_id": 2,
        "author_name": "Tony Robbins"
      },
    ];
  }
}

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
