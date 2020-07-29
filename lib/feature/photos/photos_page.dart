import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t3_demo/base/mvp.dart';
import 'package:t3_demo/bloc/photo_bloc.dart';
import 'package:t3_demo/feature/photos/photo_card.dart';
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
  ScreenState screenState = ScreenState.LOADING;
  bool isLoadingMoreItems = false;
  List<Photo> photos = [];
  final albumId;

  _PhotosPageState(this.albumId) {
    photosPresenter = PhotosPresenterImpl(photosView: this, albumId: albumId);
  }

  void _handleScrollHitBottom() {
    if (!isLoadingMoreItems) {
      photosPresenter.retrieveMorePhotos();
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        _handleScrollHitBottom();
      }
    });

    photosPresenter.init();
  }

  @override
  Widget build(BuildContext context) {
    final PhotoBloc photoBloc = Provider.of<PhotoBloc>(context);

    return Scaffold(
      appBar: _getAppBar(),
      key: _scaffoldKey,
      body: _getMainContent(photoBloc),
    );
  }

  Widget _getMainContent(PhotoBloc photoBloc) {
    switch (screenState) {
      case ScreenState.LOADING:
        return T3Widget.STANDARD_PROGRESS;
      case ScreenState.ERROR:
        return T3Widget.getRetryWidget(() {
          photosPresenter.retrieveInitialPhotos();
        });
      case ScreenState.CONTENT:
      default:
        return ListView.builder(
            controller: _scrollController,
            itemCount: photos.length,
            itemBuilder: (BuildContext context, int index) {
              Photo photo = photos[index];
              return PhotoCard(
                  photo: photo,
                  onPressed: () {
                    photoBloc.photo = photo;
                    navigateToPhotoDetails(photo, photoBloc);
                  });
            });
    }
  }

  Widget _getAppBar() => Platform.isIOS
      ? CupertinoNavigationBar(
          previousPageTitle: Strings.ALBUMS,
        )
      : AppBar(title: Text(Strings.ALBUM_PHOTOS));

  @override
  void showException(String exceptionMessage) {
    final snackBar = SnackBar(content: Text(exceptionMessage));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  void navigateToPhotoDetails(Photo photo, PhotoBloc photoBloc) {
    Navigator.of(context).pushNamed(T3Route.PHOTO_DETAILS);
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

  @override
  void setScreenState(ScreenState screenState) {
    setState(() {
      this.screenState = screenState;
    });
  }
}
