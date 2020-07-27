import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Url {
  static const ALBUMS = "/albums";
  static const PHOTOS = "/photos";
  static const BASE_URL = "jsonplaceholder.typicode.com";
}

class Asset {
  static const PLACEHOLDER_LOCATION = "assets/placeholder_image.png";
}

class Strings {
  static const String DEFAULT_ERROR_MESSAGE =
      "Something went wrong, please try again";
  static const String DEFAULT_ALBUM_TITLE = "No title found";
  static const String LOADING_MORE_PHOTOS = "Loading more photos...";
  static const String ALBUM_ID = "Album Id";
  static const String ID = "Id";
  static const String ALBUMS = "Albums";
  static const String ALBUM_PHOTOS = "Album Photos";
  static const String TITLE = "Title";
  static const String RETRY = "Retry";
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
  static const kStandardRowParams =
      EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0);
}

class Num {
  static const MAX_PHOTOS_PER_ALBUM = 5;
  static const THUMBNAIL_SIZE = 150.0;
  static const FULL_SIZE = 600.0;
  static const QUICK_SNACKBAR = 1500;
  static const STANDARD_PROGRESS = 50.0;
  static const STANDARD_PROGRESS_STROKE = 5.0;
  static const STANDARD_PADDING = 8.0;
  static const PORTRAIT_ALBUM_COLUMN = 2;
  static const PHOTOS_PER_PAGE = 10;
}

class T3Widget {
  static const STANDARD_PROGRESS = Center(
    child: SizedBox(
      height: Num.STANDARD_PROGRESS,
      width: Num.STANDARD_PROGRESS,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        strokeWidth: Num.STANDARD_PROGRESS_STROKE,
      ),
    ),
  );

  static Widget getRetryWidget(Function onPressed) {
    return Center(
      child: MaterialButton(
          padding: EdgeInsets.all(24.0),
          child: Text(Strings.RETRY),
          onPressed: onPressed),
    );
  }
}
