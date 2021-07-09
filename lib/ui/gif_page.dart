import 'package:buscador_de_gifs/bloc/gif_bloc.dart';
import 'package:flutter/material.dart';

class GifPage extends StatelessWidget {

  final Map _gifData;
  GifPage(this._gifData);

  @override
  Widget build(BuildContext context) {
    GifBloc _gifBloc = GifBloc(_gifData["images"]["fixed_height"]["url"]);

    return Scaffold(
      appBar: AppBar(
        title: Text(_gifData["title"]),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.share),
              onPressed: _gifBloc.share
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_gifData["images"]["fixed_height"]["url"]),
      ),
    );
  }
}
