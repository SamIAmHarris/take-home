import 'package:t3_demo/feature/photo_details/photo_details_contract.dart';
import 'package:t3_demo/model/photo.dart';

class PhotoDetailsPresenterImpl implements PhotoDetailsPresenter {
  final PhotoDetailsView photoDetailsView;
  Photo photo;

  PhotoDetailsPresenterImpl({this.photoDetailsView, this.photo});

  @override
  init() {
    photoDetailsView.initPhotoDetails(photo);
  }
}
