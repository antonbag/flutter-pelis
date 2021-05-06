import 'package:flutter/material.dart';
import 'package:pelis/src/models/pelicula_model.dart';
import 'package:pelis/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  //const name({Key key}) : super(key: key);

  String seleccion = '';

  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam!',
    'Ironman',
    'Capitan America',
    'Superman',
    'Ironman 2',
    'Ironman 3',
    'Ironman 4',
  ];

  final peliculasRecientes = ['Spiderman', 'Capitan America'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            print("click");
            query = '';
          })
    ];
    //throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    //icono de la izquierda
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
    //throw UnimplementedError();
    //return Container();
  }

  @override
  Widget buildResults(BuildContext context) {
    //throw UnimplementedError();
    return Center(
        child: Container(
      width: 100,
      height: 100,
      color: Colors.amberAccent,
      child: Text(seleccion),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
        future: peliculasProvider.buscarPelis(query),
        builder: (context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            final peliculas = snapshot.data!;

            return ListView(
              children: peliculas.map((pelicula) {
                return ListTile(
                  leading: FadeInImage(
                      image: NetworkImage(pelicula.getPosterImg()),
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      width: 50,
                      fit: BoxFit.cover),
                  title: Text(pelicula.title!),
                  onTap: () {
                    close(context, null);
                    Navigator.pushNamed(context, 'detalle',
                        arguments: pelicula);
                  },
                );
              }).toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });

    /*
    final listaSugerida = query.isEmpty
        ? peliculasRecientes
        : peliculas
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    //throw UnimplementedError();
    return ListView.builder(
        itemCount: peliculasRecientes.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Icon(Icons.movie),
            title: Text(listaSugerida[i]),
            onTap: () {
              seleccion = listaSugerida[i];
              showResults(context);
            },
          );
    });
    */
  }
}
