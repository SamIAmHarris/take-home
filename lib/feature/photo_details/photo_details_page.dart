import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t3_demo/feature/photo_details/photo_details_contract.dart';
import 'package:t3_demo/feature/photo_details/photo_details_presenter.dart';
import 'package:t3_demo/model/photo.dart';
import 'package:t3_demo/util/constants.dart';

class PhotoDetailsPage extends StatefulWidget {
  final Photo photo;

  PhotoDetailsPage(this.photo);

  @override
  _PhotoDetailsPageState createState() => _PhotoDetailsPageState(photo);
}

class _PhotoDetailsPageState extends State<PhotoDetailsPage>
    implements PhotoDetailsView {
  PhotoDetailsPresenter photoDetailsPresenter;
  Photo photo;

  _PhotoDetailsPageState(this.photo) {
    photoDetailsPresenter =
        PhotoDetailsPresenterImpl(photoDetailsView: this, photo: photo);
  }

  @override
  void initState() {
    super.initState();
    photoDetailsPresenter.init();
  }

  @override
  Widget build(BuildContext context) {
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

  @override
  void initPhotoDetails(Photo photo) {
    setState(() {
      this.photo = photo;
    });
  }
}
