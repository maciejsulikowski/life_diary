import 'package:dio/dio.dart';

class StoriesRemoteDataSource {
  Future<List<Map<String, dynamic>>?> getStories() async {
    return [
      // {
      //   "author_id": 1,
      //   "bio":
      //       "Ford jest uważany za jednego z najbardziej wpływowych przedsiębiorców w historii motoryzacji. Jego wkład w rozwój przemysłu samochodowego oraz wprowadzenie modelu T, który stał się pierwszym masowo produkowanym samochodem, jest niezaprzeczalny.",
      //   "picture":
      //       "https://cdn.pixabay.com/photo/2012/10/26/02/32/henry-ford-63113_1280.jpg",
      //   "source":
      //       "https://pixabay.com/pl/photos/henry-ford-portret-facet-63113/"
      // },
      {
        "author_id": 2,
        "bio":
            "Tony Robbins to amerykański mówca motywacyjny, pisarz i coach. Jego książki i seminaria motywacyjne przyczyniły się do zmiany życia tysięcy ludzi na całym świecie. Robbins jest znany z przekazywania narzędzi i strategii, które pomagają osiągnąć sukces i osobistą transformację.",
        "picture":
            "https://upload.wikimedia.org/wikipedia/commons/5/5e/Tony_Robbins.jpg",
        "source": "https://commons.wikimedia.org/wiki/File:Tony_Robbins.jpg"
      },
    ];
  }
}

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
