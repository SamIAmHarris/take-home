import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

//todo add several other fields. Not needed for V1.
@JsonSerializable()
class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}