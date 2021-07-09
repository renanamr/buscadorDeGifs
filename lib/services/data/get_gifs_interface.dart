abstract class IGetGifs{
  Future<Map> getGifsTrending();

  Future<Map> getSearchGifs({String search, int offset});
}