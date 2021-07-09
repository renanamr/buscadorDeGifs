import 'package:buscador_de_gifs/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

import 'gif_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeBloc _bloc;

  @override
  void initState() {
    _bloc = HomeBloc();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Image.network(
              "https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif"),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Pesquise Aqui!",
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder()),
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
                onSubmitted: _bloc.searchGif,
              ),
            ),

            Expanded(
                child: StreamBuilder<Map>(
                  initialData: {},
                  stream: _bloc.listGifs,
                  builder: (context, snapshot) {

                    if(snapshot.data.isEmpty)
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 5.0,
                        ),
                      );
                    else
                      return _createGifTable(context, snapshot.data);
                  },
                )
            )
          ],
        ));
  }

  Widget _createGifTable(BuildContext context, Map snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10
        ),
        itemCount: _bloc.getCount(snapshot["data"]),

        itemBuilder: (context, index) {
          if (_bloc.search == null || index < snapshot["data"].length)
            return InkWell(
              child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: snapshot["data"][index]["images"]["fixed_height"]["url"],
                    fit: BoxFit.cover,
                    height: 300.0,
                  ),
              onLongPress: (){
                Share.share(snapshot["data"][index]["images"]["fixed_height"]["url"]);
              },
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return GifPage(snapshot["data"][index]);
                }));
              },
            );
          else
            return GestureDetector(
              onTap: _bloc.searchMoreGif,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add, size: 70, color: Colors.white,),

                  Text(
                    "Carregar Mais",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  )
                ],
              ),
            );
        });
  }
}