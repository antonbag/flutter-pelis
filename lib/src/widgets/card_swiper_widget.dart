import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pelis/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  //quito el constructor

  final List<Pelicula> peliculas;

  CardSwiper({required this.peliculas});

  @override
  Widget build(BuildContext context) {

    final _screenH = MediaQuery.of(context).size.height;

    return CarouselSlider.builder(
        itemCount: this.peliculas.length,
        itemBuilder: (context, index, realIndex) =>
        MoviePosterImage(pelicula: this.peliculas[index]),
        options: CarouselOptions(
          height: _screenH*0.25,
            aspectRatio: 1.8, 
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
        ));
    //return Container();
  }
}

 


class MoviePosterImage extends StatelessWidget {
  
  final Pelicula pelicula;

  const MoviePosterImage({
    required this.pelicula
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'detalle', arguments: pelicula),
          child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
          placeholder: AssetImage('assets/img/no-image.jpg'), image: NetworkImage(pelicula.getBackgroundImg()), fit: BoxFit.cover,
        ),
      ),
    );
  }


}



/*
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'detalle'),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: FadeInImage(
            image: NetworkImage(snapshot.data![0].getBackgroundImg()),
            placeholder: AssetImage('assets/img/no-image.jpg'),
            fit: BoxFit.cover),
      ),
    );

*/
