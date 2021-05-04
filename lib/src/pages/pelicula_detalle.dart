import 'package:flutter/material.dart';
import 'package:pelis/src/models/pelicula_model.dart';

class PeliculaDetalle extends StatelessWidget {
  //no se por que se quita el constructor
  //const HombePage({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

     final Pelicula pelicula = ModalRoute.of(context)!.settings.arguments as Pelicula;


    return Scaffold(
        appBar: AppBar(title: Text("Pelicula Detalle")),
        body: Column(
          children: [
            SizedBox(height: 10),
            _posterTitulo(context, pelicula),
            _description(pelicula)
          ]
        )
    );
  }
}


Widget _posterTitulo(BuildContext context, Pelicula pelicula){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Row(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image(image: NetworkImage(pelicula.getPosterImg()),height: 150),
      ),
      SizedBox(width: 20),
      Flexible(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Text(pelicula.title!, style:Theme.of(context).textTheme.headline4, overflow:TextOverflow.clip),
          Text(pelicula.originalTitle!, style:Theme.of(context).textTheme.subtitle2, overflow:TextOverflow.clip),
          Row(
            children:[
              Icon(Icons.ac_unit),
              Text(9.toString(), style: Theme.of(context).textTheme.subtitle2)
            ]
          )
        ]
      ),)
    ],)
  );
}


Widget _description(Pelicula pelicula){

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child:Text(pelicula.overview!)
  );

}
