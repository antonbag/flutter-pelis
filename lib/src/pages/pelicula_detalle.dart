import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:pelis/src/models/actores_model.dart';
import 'package:pelis/src/models/pelicula_model.dart';
import 'package:pelis/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  //no se por que se quita el constructor
  //const HombePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula =
        ModalRoute.of(context)!.settings.arguments as Pelicula;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppBar(pelicula),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(height: 10),
            _posterTitulo(context, pelicula),
            _description(pelicula),
            _crearCasting(pelicula)
          ]))
        ],
      ),
/*         body: Column(
          children: [
            SizedBox(height: 10),
            _posterTitulo(context, pelicula),
            _description(pelicula)
          ]
        ) */ 
    );
  }
}

Widget _crearAppBar(Pelicula pelicula) {
  return SliverAppBar(
    elevation: 1,
    backgroundColor: Colors.black12,
    expandedHeight: 200,
    floating: false,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: false,
      title: Text(pelicula.title!,
          style: TextStyle(color: Colors.white70, fontSize: 16)),
      background: Hero(
          tag: pelicula.uniqueId,
          child: FadeInImage(
            image: NetworkImage(pelicula.getBackgroundImg()),
            placeholder: AssetImage('assets/img/loading.gif'),
            fadeInDuration: Duration(milliseconds: 500),
            fit: BoxFit.cover,
          ),
      ),
    ),
    actions: [],
  );
}

Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag:pelicula.uniqueIdBanner,
                      child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                  image: NetworkImage(pelicula.getPosterImg()), height: 150),
            ),
          ),
          SizedBox(width: 20),
          Flexible(
            child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              FadeIn(
                delay:Duration(milliseconds: 200),
                child: Text(pelicula.title!,
                style: Theme.of(context).textTheme.headline4,
                overflow: TextOverflow.clip),
              ),

              FadeIn(
                  delay:Duration(milliseconds: 400),
                    child: Text(pelicula.originalTitle!,
                    style: Theme.of(context).textTheme.subtitle2,
                    overflow: TextOverflow.clip),
              ),
              FadeIn(
                  delay:Duration(milliseconds: 1000),
                  child: Row(children: [
                  Icon(Icons.ac_unit),
                  Text(9.toString(), style: Theme.of(context).textTheme.subtitle2)
                ]),
              )
            ]),
          )
        ],
      ));
}

Widget _description(Pelicula pelicula) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Text(pelicula.overview!));
}

Widget _crearCasting(Pelicula pelicula) {
  final peliProvider = new PeliculasProvider();

  return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data as List<Actor>);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      });

  //return Container();
}

Widget _crearActoresPageView(List<Actor> actores) {
 
  return SizedBox(
    height: 130,
    child: ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: PageController(),
          itemCount: actores.length,
          itemBuilder: (context, i) => _actorTarjeta(actores[i])
    ),
  );
}

Widget _actorTarjeta(Actor actor) {


  return Container(
    margin: EdgeInsets.only(left: 15),
    child: Column(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeInImage(
          image: NetworkImage(actor.getFoto()),
          placeholder: AssetImage('assets/img/no-image.jpg'),
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
      Container(
        width: 100,
        child: Text(
          actor.name.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10),
          ),
      )
    ]),
  );
}
