import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t3_demo/feature/photo_details/photo_details_contract.dart';
import 'package:t3_demo/feature/photo_details/photo_details_presenter.dart';
import 'package:t3_demo/model/photo.dart';
import 'package:t3_demo/util/constants.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoDetailsPage extends StatefulWidget {
  final Photo photo;

  PhotoDetailsPage(this.photo);

  @override
  _PhotoDetailsPageState createState() => _PhotoDetailsPageState(photo);
}

class _PhotoDetailsPageState extends State<PhotoDetailsPage>
    implements PhotoDetailsView {
  PhotoDetailsPresenter photoDetailsPresenter;
  final Photo photo;

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
            SizedBox(
              child: Center(
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/placeholder_image.png",
                  image: photo.url,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 2.0),
              child: Text("Id: ${photo.id}"),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
              child: Text("Album Id: ${photo.albumId}"),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
              child: Text("Title: ${photo.title}"),
            )
          ],
        ),
      ),
    );
  }

  @override
  void navigateToTheAppWithinTheApp() {
    //todo: I want to navigate to the app hosted on the web. Appception.
  }

  @override
  void initPhotoDetails(Photo photo) {
    // TODO: implement initPhotoDetails
  }
}
