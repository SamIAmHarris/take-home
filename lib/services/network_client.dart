import 'package:flutter/foundation.dart';
import 'package:t3_demo/model/album.dart';
import 'package:t3_demo/model/photo.dart';
import 'package:t3_demo/services/result.dart';
import 'package:t3_demo/util/constants.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkClient {
  //No caching needed for this demo. But we could cache on this local instance if we wanted.
  static final NetworkClient networkClient = new NetworkClient._internal();

  factory NetworkClient(name) => networkClient;

  NetworkClient._internal();

  static Future<Result<List<Album>>> getAlbums() async {
    List<dynamic> data = await makeBaseCall(url: Url.ALBUMS);
    List<Album> albums = data.map((e) => Album.fromJson(e)).toList();
    print(albums);
    return Result.success(albums);
  }

  static Future<Result<List<Photo>>> getPhotosForAlbum(
      {int albumId, int pageNum}) async {
    Map<String, String> queryParams = {
      Param.ALBUM_ID: albumId.toString(),
      Param.START: pageNum.toString(),
      Param.LIMIT: 10.toString()
    };

    List<dynamic> data =
        await makeBaseCall(url: Url.PHOTOS, queryParams: queryParams);
    List<Photo> photos = data.map((e) => Photo.fromJson(e)).toList();
    print(photos);
    return Result.success(photos);
  }

  static Future<dynamic> makeBaseCall(
      {String url, Map<String, String> queryParams}) async {
    String baseUrl = getBaseUrl();

    var uri = Uri.https(baseUrl, url, queryParams);
    print("API CALL: ${uri.toString()}");

    http.Response response = await http.get(
      uri,
    );

    if (response.statusCode != 200) {
      print("Throwing exception from base call");
      print("status code: " + response.statusCode.toString());
      throw Exception(Strings.DEFAULT_ERROR_MESSAGE);
    }

    dynamic data = jsonDecode(response.body);
    print("status code: " + response.statusCode.toString());
    print(data);
    return data;
  }

  static String getBaseUrl() {
    if (kReleaseMode) {
      return Url.BASE_PROD_URL;
    } else {
      return Url.BASE_DEV_URL;
    }
  }
}
