import 'package:buscador_de_gifs/services/data/get_gifs_interface.dart';
import 'package:buscador_de_gifs/services/repositories/get_gifs_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class GetGifsMock extends Mock implements IGetGifs{}

void main(){
  final datasource = GetGifsMock();
  final repository = GetGifsRepository(getGifs: datasource);

  final String search = "Teste";
  final int offset = 1;

  test("GetGifsRepository getGifsTrending retorna Map quando ok", () async {
    when(datasource.getGifsTrending())
        .thenAnswer((realInvocation) async => Map());
    var response = await repository.getGifsTrending();

    expect(response, isA<Map>());
  });

  test("GetGifsRepository getGifsTrending retorna exception quando não ok", () async {
    when(datasource.getGifsTrending()).thenThrow(Exception());

    expect(repository.getGifsTrending(), throwsException);
  });


  test("GetGifsRepository getSearchGifs retorna Map quando ok", () async {
    when(datasource.getSearchGifs(search: search,offset: offset)
    ).thenAnswer((realInvocation) async => Map());

    var response = await repository.getSearchGifs(search: search,offset: offset);

    expect( response, isA<Map>());
  });

  test("GetGifsRepository getSearchGifs retorna exception quando não ok", () async {
    when(datasource.getSearchGifs(search: search,offset: offset))
        .thenThrow(Exception());

    expect(repository.getSearchGifs(search: search,offset: offset), throwsException);
  });
}