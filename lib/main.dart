import 'package:flutter/material.dart';
import 'package:t3_demo/feature/albums/albums_page.dart';
import 'package:t3_demo/feature/photo_details/photo_detail_arguments.dart';
import 'package:t3_demo/feature/photo_details/photo_details_page.dart';
import 'package:t3_demo/feature/photos/photos_page.dart';
import 'package:t3_demo/util/constants.dart';

import 'feature/photos/photos_arguments.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Jeff',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: generateRoute,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case T3Route.HOME:
      case T3Route.ALBUMS:
        return MaterialPageRoute(builder: (_) => AlbumsPage());
      case T3Route.PHOTOS:
        final PhotosArguments args = settings.arguments;
        return MaterialPageRoute(builder: (_) => PhotosPage(args.albumId));
      case T3Route.PHOTO_DETAILS:
        final PhotoDetailsArguments args = settings.arguments;
        return MaterialPageRoute(builder: (_) => PhotoDetailsPage(args.photo));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}'))));
    }
  }
}
