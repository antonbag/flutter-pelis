class Peliculas {

  List<Pelicula> items = [];

  //constructor
  Peliculas();

  Peliculas.fromJsonList( List<dynamic> jsonList  ) {

    for ( var item in jsonList  ) {
      final temp = new Pelicula.fromJsonMap(item);
      items.add( temp );
    }
  }
}




class Pelicula {
  
  double? popularity;
  int? voteCount;
  bool? video;
  String? posterPath;
  int? id;
  bool? adult;
  String? backdropPath;
  String? originalLanguage;
  String? originalTitle;
  List<int>? genreIds;
  String? title;
  double? voteAverage;
  String? overview;
  String? releaseDate;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle, 
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });


  Pelicula.fromJsonMap( Map<String, dynamic> json ) {
    voteCount        = json['vote_count'];
    id               = json['id'];
    video            = json['video'];
    voteAverage      = json['vote_average'] / 1;
    title            = json['title'];
    popularity       = json['popularity'] / 1;
    posterPath       = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle    = json['original_title'];
    genreIds         = json['genre_ids'].cast<int>();
    backdropPath     = json['backdrop_path'];
    adult            = json['adult'];
    overview         = json['overview'];
    releaseDate      = json['release_date'];
  }
  

  get uniqueId {
    return '$id-tarjeta';
  }

  get uniqueIdBanner {
    return '$id-banner';
  }

  getPosterImg() {
    if ( posterPath == null ) {
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Imagen_no_disponible.svg/1200px-Imagen_no_disponible.svg.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackgroundImg() {
    if ( backdropPath == null ) {
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Imagen_no_disponible.svg/1200px-Imagen_no_disponible.svg.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}
