import 'package:flutter/material.dart';
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
  bool isLoading = false;
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
      return GridView.builder(
          itemCount: albums.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return _buildGridItem(albums[index]);
          });
    }
  }

  Widget _buildGridItem(Album album) {
    return GestureDetector(
        onTap: () {
          navigateToPhotoDetailScreen(album.id);
        },
        child: getAlbumCard(album));
  }

  Widget getAlbumCard(Album album) {
    return Card(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          album.title ?? Strings.DEFAULT_ALBUM_TITLE,
          style: Styles.kCardAlbumStyle,
          textAlign: TextAlign.center,
        ),
      )),
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
  void showLoading(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }
}
