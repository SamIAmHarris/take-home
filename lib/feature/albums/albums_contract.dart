import 'package:t3_demo/base/mvp.dart';
import 'package:t3_demo/model/album.dart';

abstract class AlbumsPresenter implements BasePresenter {
  Future<void> retrieveAlbums();
}

abstract class AlbumsView implements BaseView<AlbumsPresenter> {
  void showLoading(bool isLoading);

  void showException(String exceptionMessage);

  void setAlbums(List<Album> albums);

  void navigateToPhotoDetailScreen(int albumId);
}
