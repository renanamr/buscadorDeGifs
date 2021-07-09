import 'dart:convert' show json;
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class HomeBloc{

  String search;
  int offset = 0;
  final urlBase ="https://api.giphy.com/v1/gifs";

  HomeBloc(){
    getGifs();
  }

  BehaviorSubject<Map> _gifsStream = BehaviorSubject();

  Stream<Map> get listGifs => _gifsStream.stream;


  Future<Map> getGifs() async {
    _gifsStream..sink.add({});//modo de espera
    http.Response response;

    if (search == null)
      response = await http.get(urlBase+"/trending?api_key=BGrSLJVE8IyRjGCIYPW5QlJ6e3A3afEJ&limit=20&rating=G");
    else
      response = await http.get(
          "$urlBase/search?api_key=BGrSLJVE8IyRjGCIYPW5QlJ6e3A3afEJ&q=$search&limit=19&offset=$offset&rating=G&lang=en");


    final map = json.decode(response.body);//Mostrar informações
    _gifsStream.sink.add(map);

    return map;
  }


  int getCount(List data) {
    if (search == null || search.isEmpty) {
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  void searchGif(String texto) {
    search = texto;
    offset = 0;
    getGifs();
  }

  void searchMoreGif() {
    offset += 19;
    getGifs();
  }



  void dispose(){
    _gifsStream.close();
  }
}