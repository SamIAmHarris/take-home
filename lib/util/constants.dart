import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Url {
  static const ALBUMS = "/albums";
  static const PHOTOS = "/photos";

  //THEY ARE THE SAME SAM, WHY DID YOU DO THIS? BECAUSE THERE IS SOMETHING WRONG WITH ME.
  static const BASE_DEV_URL = "jsonplaceholder.typicode.com";
  static const BASE_PROD_URL = "jsonplaceholder.typicode.com";
}

class Strings {
  static const String DEFAULT_ERROR_MESSAGE =
      "Something went wrong, please try again";
  static const String DEFAULT_ALBUM_TITLE = "Jeff, did you read all the code?";
  static const String LOADING_MORE_PHOTOS = "Jeff, we are loading more photos for you...";
}

class Param {
  static const String ALBUM_ID = "albumId";
  static const String START = "_start";
  static const String LIMIT = "_limit";
}

class T3Route {
  static const HOME = "/";
  static const ALBUMS = "/albums";
  static const PHOTOS = "/photos";
  static const PHOTO_DETAILS = "/photoDetails";
}

class Styles {
  static const kCardAlbumStyle = TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black87);
}

class Num {
  static const MAX_PHOTOS_PER_ALBUM = 5;
  static const THUMBNAIL_SIZE = 150.0;
  static const FULL_SIZE = 600.0;
  static const QUICK_SNACKBAR = 1500;
}
