import 'package:buscador_de_gifs/services/data/get_gifs.dart';
import 'package:buscador_de_gifs/services/data/get_gifs_interface.dart';
import 'package:buscador_de_gifs/services/repositories/get_gifs_repository_interface.dart';


class GetGifsRepository extends IGetGifsRepository{

  IGetGifs _getGifs;

  GetGifsRepository({IGetGifs getGifs}){
    _getGifs = getGifs ?? GetGifsImpl();
  }

  @override
  Future<Map> getGifsTrending() async {
    try{
      return _getGifs.getGifsTrending();
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<Map> getSearchGifs({String search, int offset}) async{
    try{
      return _getGifs.getSearchGifs(search: search, offset: offset);
    }catch(e){
      rethrow;
    }
  }

}