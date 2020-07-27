import 'package:t3_demo/base/mvp.dart';
import 'package:t3_demo/feature/albums/albums_contract.dart';
import 'package:t3_demo/model/album.dart';
import 'package:t3_demo/services/network_client.dart';
import 'package:t3_demo/services/result.dart';
import 'package:t3_demo/util/constants.dart';

class AlbumsPresenterImpl implements AlbumsPresenter {
  final AlbumsView albumsView;

  AlbumsPresenterImpl(this.albumsView);

  @override
  init() {
    retrieveAlbums();
  }

  @override
  Future<void> retrieveAlbums() async {
    try {
      albumsView.setScreenState(ScreenState.LOADING);
      Result<List<Album>> albumsResult = await NetworkClient.getAlbums();

      if (albumsResult.status == Status.SUCCESS) {
        albumsView.setAlbums(albumsResult.data);
        albumsView.setScreenState(ScreenState.CONTENT);
      } else {
        albumsView.showException(albumsResult.message);
        albumsView.setScreenState(ScreenState.ERROR);
      }
    } catch (e) {
      albumsView.setScreenState(ScreenState.ERROR);
      albumsView.showException(Strings.DEFAULT_ERROR_MESSAGE);
    }
  }
}
