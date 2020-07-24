import 'package:t3_demo/feature/albums/albums_contract.dart';
import 'package:t3_demo/model/album.dart';
import 'package:t3_demo/services/network_client.dart';
import 'package:t3_demo/services/result.dart';

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
      albumsView.showLoading(true);
      Result<List<Album>> albumsResult = await NetworkClient.getAlbums();

      if (albumsResult.status == Status.SUCCESS) {
        albumsView.showLoading(false);
        albumsView.setAlbums(albumsResult.data);
      } else {
        albumsView.showException(albumsResult.message);
      }
    } catch (e) {
      albumsView.showLoading(false);
    }
  }
}
