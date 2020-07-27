import 'package:t3_demo/base/mvp.dart';
import 'package:t3_demo/model/photo.dart';

abstract class PhotoDetailsPresenter implements BasePresenter {}

abstract class PhotoDetailsView implements BaseView<PhotoDetailsPresenter> {
  //Ideally on a more full fledged app, I would save the photo info to a local db,
  //just pass the photo id to the detail page, then retrieve it within photo detail app.
  //But here I am just passing the ful photo, so this init details isn't super useful.
  void initPhotoDetails(Photo photo);
}
