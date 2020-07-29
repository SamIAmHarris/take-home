import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t3_demo/model/photo.dart';
import 'package:t3_demo/util/constants.dart';

class PhotoDetailsPage extends StatelessWidget {
  final Photo photo;

  PhotoDetailsPage(this.photo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FullSizePhotoWidget(photo.url),
              MetaDataText(
                padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 2.0),
                title: "${Strings.TITLE}: ${photo.title}",
              ),
              MetaDataText(
                  padding: Styles.kStandardRowParams,
                  title: "${Strings.ALBUM_ID}: ${photo.albumId}"),
              MetaDataText(
                padding: Styles.kStandardRowParams,
                title: "${Strings.ID}: ${photo.id}",
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MetaDataText extends StatelessWidget {
  final String title;
  final EdgeInsets padding;

  MetaDataText({this.title, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: padding, child: Text(title));
  }
}

class FullSizePhotoWidget extends StatelessWidget {
  final String url;

  FullSizePhotoWidget(this.url);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: FadeInImage.assetNetwork(
          placeholder: Asset.PLACEHOLDER_LOCATION,
          image: url,
        ),
      ),
    );
  }
}
