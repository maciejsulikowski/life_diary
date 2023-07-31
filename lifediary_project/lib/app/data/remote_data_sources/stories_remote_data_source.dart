import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lifediary_project/app/domain/models/stories_model.dart';
import 'package:retrofit/retrofit.dart';

part 'stories_remote_data_source.g.dart';

@injectable
@RestApi()
abstract class StoriesRemoteRetrofitDataSource {
  @factoryMethod
  factory StoriesRemoteRetrofitDataSource(@Named('Dio2') Dio dioSecondUrl) =
      _StoriesRemoteRetrofitDataSource;

  @GET("/stories")
  Future<List<StoriesModel>> getStories();
}


// class StoriesRemoteDioDataSource {
//   Future<List<Map<String, dynamic>>?> getStories() async {
//     final response = await Dio().get<List<dynamic>>(
//         'https://my-json-server.typicode.com/maciejsulikowski/json-demo/stories');
//     final listDynamic = response.data;
//     if (listDynamic == null) {
//       return null;
//     }
//     return listDynamic.map((item) => item as Map<String, dynamic>).toList();
//   }
// }
