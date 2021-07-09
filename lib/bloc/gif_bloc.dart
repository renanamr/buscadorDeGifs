import 'package:share/share.dart';

class GifBloc{
  final gif;
  GifBloc(this.gif);

  share()=> Share.share(gif);
}