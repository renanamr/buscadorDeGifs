import 'package:buscador_de_gifs/services/data/get_gifs.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter{
}

void main(){

  var dio = Dio();
  var adapter = DioAdapterMock();
  dio.httpClientAdapter = adapter;

  final getGifs = GetGifsImpl(dio: dio);

  final String search = "Teste";
  final int offset = 12;
  var json = '''{
      "test": "test"
    }''';

  test("GetGifsTrending retorna map quando conclui com sucesso", () async {
    when(adapter.fetch(any, any, any))
        .thenAnswer((_) async => ResponseBody.fromString(json, 200, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType]
    }));

    var response = await getGifs.getGifsTrending();
    expect(response, isA<Map<dynamic, dynamic>>());
  });

  test("GetGifsTrending retorna exception quando != 200", () async {
    when(adapter.fetch(any, any, any))
        .thenAnswer((_) async => ResponseBody.fromString(json, 400, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType]
    }));

    expect(getGifs.getGifsTrending(), throwsException);
  });

  test("GetGifsTrending retorna exception quando não ok", () async {
    when(adapter.fetch(any, any, any))
        .thenThrow(Exception());

    expect(getGifs.getGifsTrending(), throwsException);
  });


  test("GetSearchGifs retorna map quando conclui com sucesso", () async {
    when(adapter.fetch(any, any, any))
        .thenAnswer((_) async => ResponseBody.fromString(json, 200, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType]
    }));

    var response = await getGifs.getSearchGifs(search: search, offset: offset);
    expect(response, isA<Map<dynamic, dynamic>>());
  });

  test("GetSearchGifs retorna exception quando != 200", () async {
    when(adapter.fetch(any, any, any))
        .thenAnswer((_) async => ResponseBody.fromString(json, 400, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType]
    }));

    expect(getGifs.getSearchGifs(search: search, offset: offset), throwsException);
  });

  test("GetSearchGifs retorna exception quando não ok", () async {
    when(adapter.fetch(any, any, any))
        .thenThrow(Exception());

    expect(getGifs.getSearchGifs(search: search, offset: offset), throwsException);
  });

}