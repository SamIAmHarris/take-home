import 'package:t3_demo/base/mvp.dart';
import 'package:t3_demo/model/photo.dart';

abstract class PhotosPresenter implements BasePresenter {
  Future<void> retrievePhotos({bool loadingMoreItems = false});

  void increasePageCount(int increaseByNum);
}

abstract class PhotosView implements BaseView<PhotosPresenter> {
  void showLoading(bool isLoading);

  void showLoadingMoreItemsAlert();

  void loadingMoreItems(bool isLoadingMoreItems);

  void showException(String exceptionMessage);

  void setPhotos(List<Photo> photos);

  void navigateToPhotoDetails(Photo photo);
}
