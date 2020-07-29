import 'package:t3_demo/base/mvp.dart';
import 'package:t3_demo/feature/photos/photos_contract.dart';
import 'package:t3_demo/model/photo.dart';
import 'package:t3_demo/services/network_client.dart';
import 'package:t3_demo/services/result.dart';
import 'package:t3_demo/util/constants.dart';

class PhotosPresenterImpl implements PhotosPresenter {
  final PhotosView photosView;
  final int albumId;
  int currentPage = 0;
  List<Photo> loadedPhotos = [];

  PhotosPresenterImpl({this.photosView, this.albumId});

  @override
  init() {
    retrieveInitialPhotos();
  }

  //Initially I had these 2 methods combined into one with bool to indicate loading more.
  //Decided it is cleaner to keep them separate since loading more never changes screen state.
  @override
  Future<void> retrieveInitialPhotos() async {
    try {
      photosView.setScreenState(ScreenState.LOADING);

      Result<List<Photo>> photosResult =
          await NetworkClient.getPhotosForAlbum(albumId: albumId, pageNum: 0);

      if (photosResult.status == Status.SUCCESS) {
        loadedPhotos.addAll(photosResult.data);
        photosView.setPhotos(loadedPhotos);
        photosView.setScreenState(ScreenState.CONTENT);
      } else {
        photosView.setScreenState(ScreenState.ERROR);
        photosView.showException(photosResult.message);
      }
    } catch (e) {
      photosView.loadingMoreItems(false);
      photosView.showException(Strings.DEFAULT_ERROR_MESSAGE);
    }
  }

  @override
  Future<void> retrieveMorePhotos() async {
    if (currentPage >= Num.MAX_PHOTOS_PER_ALBUM - 1) {
      return;
    }

    photosView.loadingMoreItems(true);
    photosView.showLoadingMoreItemsAlert();

    try {
      Result<List<Photo>> photosResult = await NetworkClient.getPhotosForAlbum(
          albumId: albumId, pageNum: (currentPage + 1) * Num.PHOTOS_PER_PAGE);

      photosView.loadingMoreItems(false);
      if (photosResult.status == Status.SUCCESS) {
        currentPage++;
        loadedPhotos.addAll(photosResult.data);
        photosView.setPhotos(loadedPhotos);
      } else {
        photosView.showException(photosResult.message);
      }
    } catch (e) {
      photosView.loadingMoreItems(false);
      photosView.showException(Strings.DEFAULT_ERROR_MESSAGE);
    }
  }
}
