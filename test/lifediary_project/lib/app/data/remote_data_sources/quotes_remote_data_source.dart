import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lifediary_project/app/domain/models/quotes_model.dart';
import 'package:retrofit/retrofit.dart';

part 'quotes_remote_data_source.g.dart';

@injectable
@RestApi()
abstract class QuotesRemoteRetrofitDataSource {
  @factoryMethod
  factory QuotesRemoteRetrofitDataSource(@Named('Dio2') Dio dioSecondUrl) =
      _QuotesRemoteRetrofitDataSource;

  @GET("/quotes")
  Future<List<QuotesModel>> getQuotes();
}

// class QuotesRemoteDioDataSource {
//   Future<List<Map<String, dynamic>>?> getQuotes() async {
//     final response = await Dio().get<List<dynamic>>(
//         'https://my-json-server.typicode.com/maciejsulikowski/json-demo/quotes');
//     final listDynamic = response.data;
//     if (listDynamic == null) {
//       return null;
//     }
//     return listDynamic.map((item) => item as Map<String, dynamic>).toList();
//   }
// }
