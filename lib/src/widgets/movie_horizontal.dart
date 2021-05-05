import 'package:flutter/material.dart';
import 'package:pelis/src/models/pelicula_model.dart';


class MovieHorizontal extends StatelessWidget {
  //const MovieHorizontal({Key key}) : super(key: key);

  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({required this.peliculas, required this.siguientePagina});

  final _pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    //return _tarjeta(context, pelicula, _screenSize);

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
    
        //EJECUTO LA FUNCION PASADA POR LA CLASE
        siguientePagina();

      }
    }); 

    return Container(
      color: Colors.pink,
      height: 250,
      padding: EdgeInsets.only(top: 20),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          itemCount: peliculas.length,
          itemBuilder: (context, i) =>
              _tarjeta(context, peliculas[i], _screenSize)),
    );
  }
}

Widget _tarjeta(BuildContext context, Pelicula pelicula, _screenSize) {
  final tarjeta = Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(pelicula.getPosterImg()),
              fit: BoxFit.cover,
              height: 150),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          width: 150,
          child: Text(pelicula.title!, textAlign: TextAlign.center),
        )
      ],
    ),
  );

  return GestureDetector(
    child: tarjeta,
    onTap: () {
      Navigator.pushNamed(context, 'detalle', arguments: pelicula);
    },
  );
}
