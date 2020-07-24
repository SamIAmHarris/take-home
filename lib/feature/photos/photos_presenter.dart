import 'package:t3_demo/feature/photos/photos_contract.dart';
import 'package:t3_demo/model/photo.dart';
import 'package:t3_demo/services/network_client.dart';
import 'package:t3_demo/services/result.dart';
import 'package:t3_demo/util/constants.dart';

class PhotosPresenterImpl implements PhotosPresenter {
  final PhotosView photosView;
  int albumId;
  int currentPage = 0;
  List<Photo> loadedPhotos = [];

  PhotosPresenterImpl({this.photosView, this.albumId});

  @override
  init() {
    retrievePhotos();
  }

  @override
  Future<void> retrievePhotos({bool loadingMoreItems = false}) async {
    if (currentPage >= Num.MAX_PHOTOS_PER_ALBUM) {
      return;
    }

    try {
      if (loadingMoreItems) {
        photosView.loadingMoreItems(true);
        photosView.showLoadingMoreItemsAlert();
      } else {
        photosView.showLoading(true);
      }

      Result<List<Photo>> photosResult = await NetworkClient.getPhotosForAlbum(
          albumId: albumId, pageNum: currentPage * 10);

      if (photosResult.status == Status.SUCCESS) {
        photosView.loadingMoreItems(false);
        photosView.showLoading(false);
        loadedPhotos.addAll(photosResult.data);
        photosView.setPhotos(loadedPhotos);
      } else {
        photosView.loadingMoreItems(false);
        photosView.showLoading(false);
        photosView.showException(photosResult.message);
      }
    } catch (e) {
      photosView.loadingMoreItems(false);
      photosView.showLoading(false);
    }
  }

  @override
  void increasePageCount(int increaseByNum) {
    currentPage += increaseByNum;
  }
}
