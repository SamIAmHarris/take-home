import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:t3_demo/base/mvp.dart';
import 'package:t3_demo/model/album.dart';
import 'package:t3_demo/model/photo.dart';
import 'package:t3_demo/services/result.dart';
import 'package:t3_demo/util/constants.dart';
import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkClient {
  //No caching needed for this demo. But we could cache on this instance if we wanted.
  static final NetworkClient networkClient = new NetworkClient._internal();

  factory NetworkClient(name) => networkClient;

  NetworkClient._internal();

  static Future<Result<List<Album>>> getAlbums() async {
    List<dynamic> data;
    try {
      data = await makeBaseCall(url: Url.ALBUMS);
    } on BaseCallException catch (e) {
      return Result.error(e.cause);
    }

    //List Parsing example using forEach
    List<Album> albums = [];
    data.forEach((element) {
      albums.add(Album.fromJson(element));
    });
    return Result.success(albums);
  }

  static Future<Result<List<Photo>>> getPhotosForAlbum(
      {int albumId, int pageNum}) async {
    Map<String, String> queryParams = {
      Param.ALBUM_ID: albumId.toString(),
      Param.START: pageNum.toString(),
      Param.LIMIT: Num.PHOTOS_PER_PAGE.toString()
    };

    List<dynamic> data;
    try {
      data = await makeBaseCall(url: Url.PHOTOS, queryParams: queryParams);
    } on BaseCallException catch (e) {
      return Result.error(e.cause);
    }
    //List Parsing example using map
    List<Photo> photos = data.map((e) => Photo.fromJson(e)).toList();
    return Result.success(photos);
  }

  static Future<dynamic> makeBaseCall(
      {String url, Map<String, String> queryParams}) async {
    var uri = Uri.https(Url.BASE_URL, url, queryParams);
    print("API CALL: ${uri.toString()}");

    http.Response response = await http.get(uri);

    if (response.statusCode != 200) {
      print("Throwing exception from base call");
      print("status code: " + response.statusCode.toString());
      //Could throw a more specific exception here with the message attached to it.
      String errorMessage =
          response.reasonPhrase ?? Strings.DEFAULT_ERROR_MESSAGE;
      throw BaseCallException(errorMessage);
    }

    //This is just here to get some failures every now and then.
    Random random = Random();
    if (random.nextBool() && random.nextBool() && random.nextBool()) {
      throw BaseCallException("Testing error states");
    }

    dynamic data = jsonDecode(response.body);
    print("status code: " + response.statusCode.toString());
    return data;
  }
}
