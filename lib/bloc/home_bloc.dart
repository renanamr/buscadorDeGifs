import 'package:buscador_de_gifs/services/repositories/get_gifs_repository_interface.dart';
import 'package:buscador_de_gifs/services/repositories/get_gifs_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc{

  String search;
  int offset = 0;
  IGetGifsRepository _repositoryGetGifs;

  HomeBloc({IGetGifsRepository repositoryGetGifs}){
    _repositoryGetGifs = repositoryGetGifs ?? GetGifsRepository();
    _getGifs();
  }

  BehaviorSubject<Map> _gifsStream = BehaviorSubject();

  Stream<Map> get listGifs => _gifsStream.stream;


  Future<Map> _getGifs() async {
    _gifsStream.sink.add({});//modo de espera
    Map<String, dynamic> map;

    if (search == null)
      map = await _repositoryGetGifs.getGifsTrending();
    else
      map = await _repositoryGetGifs.getSearchGifs(search: search, offset: offset);


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
    _getGifs();
  }

  void searchMoreGif() {
    offset += 19;
    _getGifs();
  }



  void dispose(){
    _gifsStream.close();
  }
}