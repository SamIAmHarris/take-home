import 'package:t3_demo/base/mvp.dart';
import 'package:t3_demo/bloc/photo_bloc.dart';
import 'package:t3_demo/model/photo.dart';

abstract class PhotosPresenter implements BasePresenter {
  Future<void> retrieveMorePhotos();

  Future<void> retrieveInitialPhotos();
}

abstract class PhotosView implements BaseView<PhotosPresenter> {
  void setScreenState(ScreenState screenState);

  void showLoadingMoreItemsAlert();

  void loadingMoreItems(bool isLoadingMoreItems);

  void showException(String exceptionMessage);

  void setPhotos(List<Photo> photos);

  void navigateToPhotoDetails(Photo photo, PhotoBloc photoBloc);
}
