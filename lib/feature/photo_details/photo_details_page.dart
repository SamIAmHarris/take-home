import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t3_demo/bloc/photo_bloc.dart';
import 'package:t3_demo/model/photo.dart';
import 'package:t3_demo/util/constants.dart';

class PhotoDetailsPage extends StatefulWidget {
  @override
  _PhotoDetailsPageState createState() => _PhotoDetailsPageState();
}

class _PhotoDetailsPageState extends State<PhotoDetailsPage> {
  Photo photo;

  _PhotoDetailsPageState() {}

  @override
  Widget build(BuildContext context) {
    final PhotoBloc photoBloc = Provider.of<PhotoBloc>(context);
    this.photo = photoBloc.photo;

    return Scaffold(
      body: _getMainContent(),
    );
  }

  Widget _getMainContent() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getFullSizePhotoWidget(),
            _getMetadataText(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 2.0),
              title: "${Strings.TITLE}: ${photo.title}",
            ),
            _getMetadataText(
                padding: Styles.kStandardRowParams,
                title: "${Strings.ALBUM_ID}: ${photo.albumId}"),
            _getMetadataText(
              padding: Styles.kStandardRowParams,
              title: "${Strings.ID}: ${photo.id}",
            )
          ],
        ),
      ),
    );
  }

  Widget _getFullSizePhotoWidget() => SizedBox(
        child: Center(
          child: FadeInImage.assetNetwork(
            placeholder: Asset.PLACEHOLDER_LOCATION,
            image: photo.url,
          ),
        ),
      );

  Widget _getMetadataText({String title, EdgeInsets padding}) =>
      Padding(padding: padding, child: Text(title));
}
