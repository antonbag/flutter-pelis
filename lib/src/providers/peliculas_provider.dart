import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pelis/src/models/actores_model.dart';
import 'package:pelis/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = '9b89a8625cbef037f24efd4c5b3e4eb3';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  //POPULARES Streams
  int _popularesPage = 0;
  static bool cargandoPopulares = false;
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

  getPopulares() async {
    //esto no tiene mucho sentido para mi. Nunca es true
    if (cargandoPopulares) {
      print("--cargandoPopulares return []");
      return [];
    }

    this._popularesPage++;

    final Uri url = Uri.https(_url, '/3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _populares.toString()
    });

    //devuelvo
    //return await _procesarRespuesta(url);

    final resp = await _procesarRespuesta(url);
    cargandoPopulares = true;

    _populares.addAll(resp);

    ppSink(_populares);

    cargandoPopulares = false;

    //return resp;
  }

  //CAST future method
  Future<List<Actor>> getCast(String peliId) async {
    final Uri url = Uri.https(_url, '/3/movie/$peliId/credits', {
      'api_key': _apikey,
      'language': _language,
    });

    //get data from api
    final resp = await http.get(url);

    //decode data
    final decodedData = json.decode(resp.body);



    //construyo el modelo peliculas (que es una lista de tipo pelicula) con los datos de results
    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }


  //BUSCAR pelis future method
  Future<List<Pelicula>> buscarPelis(String query) async {
    final Uri url = Uri.https(_url, '/3/search/movie', {
      'api_key': _apikey,
      'language': _language,
      'query': query,
    });

    return await _procesarRespuesta(url);
  }


}
