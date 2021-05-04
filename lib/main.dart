import 'package:flutter/material.dart';
import 'package:pelis/src/pages/pelicula_detalle.dart';
import 'package:pelis/src/pages/home_page.dart';

void main() => runApp(MyApp());
 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lo de las pelis',
      debugShowCheckedModeBanner: false,
      //home: PeliculaDetalle(),
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/' : (BuildContext context) => HomePage(),
        'detalle' : (BuildContext context) => PeliculaDetalle(),
      }
    );
  }
}