import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pelis/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '9b89a8625cbef037f24efd4c5b3e4eb3';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  //populares
  int _popularesPage = 0;
  List<Pelicula> _populares = [];

  //Streamcontroller<lo que va a fluir por el stream
  final _ppStreamController = StreamController<List<Pelicula>>.broadcast();
  Function(List<Pelicula>) get ppSink => _ppStreamController.sink.add;
  Stream<List<Pelicula>> get ppStream => _ppStreamController.stream;

  //necesito cerrar el stream
  void cerrarStream() {
    _ppStreamController.close();
  }

  //EN CINES future method
  Future<List<Pelicula>> getEnCines() async {
    final Uri url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    //get data from api
    final resp = await http.get(url);

    //decode data
    final decodedData = json.decode(resp.body);

    //construyo el modelo peliculas (que es una lista de tipo pelicula) con los datos de results
    final Peliculas nowPlayingPelis =
        new Peliculas.fromJsonList(decodedData['results']);

    //devuelvo
    return nowPlayingPelis.items;
  }

  Future<List<Pelicula>> getPopulares() async {
    _popularesPage++;

    final Uri url = Uri.https(_url, '/3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page':_populares.toString()
    });

    //devuelvo
    return await _procesarRespuesta(url);
  }
}
