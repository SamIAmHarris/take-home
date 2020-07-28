import 'package:flutter/material.dart';
import 'package:t3_demo/model/photo.dart';

class PhotoBloc extends ChangeNotifier {
  Photo _photo;

  Photo get photo => _photo;

  set photo(Photo val) {
    _photo = val;
    notifyListeners();
  }
}