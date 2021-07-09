abstract class IGetGifsRepository{
  Future<Map> getGifsTrending();

  Future<Map> getSearchGifs({String search, int offset});
}