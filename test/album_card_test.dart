import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:t3_demo/feature/albums/album_card.dart';

void main() {
  String expectedAlbumTitle = "T";

  testWidgets("AlbumCard has an album title", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: AlbumCard(albumTitle: expectedAlbumTitle, onPressed: () {})));
    final titleFinder = find.text(expectedAlbumTitle);
    expect(titleFinder, findsOneWidget);
  });
}
