import 'package:t3_demo/base/mvp.dart';
import 'package:t3_demo/model/photo.dart';

abstract class PhotoDetailsPresenter implements BasePresenter {}

abstract class PhotoDetailsView implements BaseView<PhotoDetailsPresenter> {
  void initPhotoDetails(Photo photo);

  void navigateToTheAppWithinTheApp();
}
