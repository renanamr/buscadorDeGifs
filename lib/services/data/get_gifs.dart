import 'package:buscador_de_gifs/services/data/get_gifs_interface.dart';
import 'package:dio/dio.dart';


class GetGifsImpl extends IGetGifs{

  Dio _dio;
  final urlBase ="https://api.giphy.com/v1/gifs";

  GetGifsImpl({Dio dio}){
    _dio = dio ?? Dio();
  }

  @override
  Future<Map> getGifsTrending() async {
    try{
      final response = await _dio.get(
        "$urlBase/trending",
        queryParameters: {
          "api_key": "BGrSLJVE8IyRjGCIYPW5QlJ6e3A3afEJ",
          "limit"  : 20,
          "rating" : "G"
        },
      );
      return response.data;
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<Map> getSearchGifs({String search, int offset}) async{
    try{
      final response = await _dio.get(
        "$urlBase/search",
        queryParameters: {
          "api_key": "BGrSLJVE8IyRjGCIYPW5QlJ6e3A3afEJ",
          "q"      : search,
          "limit"  : 19,
          "offset" : offset,
          "rating" : "G",
          "lang"   : "en"
        },
      );

      return response.data;
    }catch(e){
      rethrow;
    }
  }

}