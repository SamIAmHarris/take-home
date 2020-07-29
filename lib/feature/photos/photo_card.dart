import 'package:flutter/material.dart';
import 'package:t3_demo/model/photo.dart';
import 'package:t3_demo/util/constants.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoCard extends StatelessWidget {
  final Photo photo;
  final VoidCallback onPressed;

  PhotoCard(this.photo, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(photo.id.toString()),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getThumbnailWidget(photo),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(Num.STANDARD_PADDING),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _getMetaDataText(
                      photo.title,
                    ),
                    _getMetaDataText(
                      "${Strings.ID} : ${photo.id}",
                    ),
                    _getMetaDataText(
                      "${Strings.ALBUM_ID} : ${photo.albumId}",
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getMetaDataText(String title) => Text(
        title,
        textAlign: TextAlign.center,
      );

  Widget _getThumbnailWidget(Photo photo) => SizedBox(
        height: Num.THUMBNAIL_SIZE,
        width: Num.THUMBNAIL_SIZE,
        child: Center(
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: photo.thumbnailUrl,
          ),
        ),
      );
}
