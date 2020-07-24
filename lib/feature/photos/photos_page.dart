import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t3_demo/feature/photo_details/photo_detail_arguments.dart';
import 'package:t3_demo/feature/photos/photos_contract.dart';
import 'package:t3_demo/feature/photos/photos_presenter.dart';
import 'package:t3_demo/model/photo.dart';
import 'package:t3_demo/util/constants.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotosPage extends StatefulWidget {
  final int albumId;

  PhotosPage(this.albumId);

  @override
  _PhotosPageState createState() => _PhotosPageState(albumId);
}

class _PhotosPageState extends State<PhotosPage> implements PhotosView {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();
  PhotosPresenter photosPresenter;
  bool isLoading = false;
  bool isLoadingMoreItems = false;
  List<Photo> photos = [];
  final albumId;

  _PhotosPageState(this.albumId) {
    photosPresenter = PhotosPresenterImpl(photosView: this, albumId: albumId);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!isLoadingMoreItems) {
          print("LOADING MORE PHOTOS");
          photosPresenter.increasePageCount(1);
          photosPresenter.retrievePhotos(loadingMoreItems: true);
        }
      }
    });

    photosPresenter.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      key: _scaffoldKey,
      body: _getMainContent(),
    );
  }

  Widget _getMainContent() {
    if (isLoading) {
      return Center(
        child: SizedBox(
          height: 50.0,
          width: 50.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            strokeWidth: 5.0,
          ),
        ),
      );
    } else {
      return ListView.builder(
          controller: _scrollController,
          itemCount: photos.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildListItem(photos[index]);
          });
    }
  }

  Widget _getAppBar() => Platform.isIOS
      ? CupertinoNavigationBar(previousPageTitle: "Albums",)
      : AppBar(title: Text("Album Photos"));

  Widget _buildListItem(Photo photo) {
    return GestureDetector(
        onTap: () {
          navigateToPhotoDetails(photo);
        },
        child: _getPhotoCard(photo));
  }

  Widget _getPhotoCard(Photo photo) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: Num.THUMBNAIL_SIZE,
            width: Num.THUMBNAIL_SIZE,
            child: Center(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: photo.thumbnailUrl,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${photo.title}",
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "${photo.albumId}",
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "${photo.id}",
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void showException(String exceptionMessage) {
    final snackBar = SnackBar(content: Text(exceptionMessage));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  void showLoading(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }

  @override
  void navigateToPhotoDetails(Photo photo) {
    Navigator.of(context).pushNamed(T3Route.PHOTO_DETAILS,
        arguments: PhotoDetailsArguments(photo));
  }

  @override
  void setPhotos(List<Photo> photos) {
    setState(() {
      this.photos = photos;
    });
  }

  @override
  void showLoadingMoreItemsAlert() {
    final snackBar = SnackBar(
      content: Text(Strings.LOADING_MORE_PHOTOS),
      duration: Duration(milliseconds: Num.QUICK_SNACKBAR),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  void loadingMoreItems(bool isLoadingMoreItems) {
    setState(() {
      this.isLoadingMoreItems = isLoadingMoreItems;
    });
  }
}
