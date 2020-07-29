import 'package:flutter/material.dart';
import 'package:t3_demo/util/constants.dart';

class AlbumCard extends StatelessWidget {
  final String albumTitle;
  final VoidCallback onPressed;

  AlbumCard({this.albumTitle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Center(
            child: Text(
          albumTitle ?? Strings.DEFAULT_ALBUM_TITLE,
          textDirection: TextDirection.ltr,
          style: Styles.kCardAlbumStyle,
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
