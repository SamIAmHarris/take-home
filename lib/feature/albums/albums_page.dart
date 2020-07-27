import 'package:flutter/material.dart';
import 'package:t3_demo/base/mvp.dart';
import 'package:t3_demo/feature/albums/albums_contract.dart';
import 'package:t3_demo/feature/albums/albums_presenter.dart';
import 'package:t3_demo/feature/photos/photos_arguments.dart';
import 'package:t3_demo/model/album.dart';
import 'package:t3_demo/util/constants.dart';

class AlbumsPage extends StatefulWidget {
  @override
  _AlbumsPageState createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> implements AlbumsView {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AlbumsPresenter albumsPresenter;
  ScreenState screenState = ScreenState.LOADING;
  bool isLoadingMoreItems = false;
  List<Album> albums = [];

  _AlbumsPageState() {
    albumsPresenter = AlbumsPresenterImpl(this);
  }

  @override
  void initState() {
    super.initState();
    albumsPresenter.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _getMainContent(),
    );
  }

  Widget _getMainContent() {
    switch (screenState) {
      case ScreenState.LOADING:
        return T3Widget.STANDARD_PROGRESS;
      case ScreenState.ERROR:
        return T3Widget.getRetryWidget(() {
          albumsPresenter.retrieveAlbums();
        });
      case ScreenState.CONTENT:
      default:
        return GridView.builder(
            itemCount: albums.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Num.PORTRAIT_ALBUM_COLUMN),
            itemBuilder: (BuildContext context, int index) {
              return _getAlbumCard(albums[index]);
            });
    }
  }

  Widget _getAlbumCard(Album album) {
    return Card(
      child: InkWell(
        onTap: () {
          navigateToPhotoDetailScreen(album.id);
        },
        child: Center(
            child: Text(
          album.title ?? Strings.DEFAULT_ALBUM_TITLE,
          style: Styles.kCardAlbumStyle,
          textAlign: TextAlign.center,
        )),
      ),
    );
  }

  @override
  void navigateToPhotoDetailScreen(int albumId) {
    Navigator.of(context)
        .pushNamed(T3Route.PHOTOS, arguments: PhotosArguments(albumId));
  }

  @override
  void setAlbums(List<Album> albums) {
    setState(() {
      this.albums = albums;
    });
  }

  @override
  void showException(String exceptionMessage) {
    final snackBar = SnackBar(content: Text(exceptionMessage));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  void setScreenState(ScreenState screenState) {
    setState(() {
      this.screenState = screenState;
    });
  }
}
