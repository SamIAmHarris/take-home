import 'package:flutter/material.dart';
import 'package:t3_demo/services/network_client.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Jeff',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DemoHome(),
    );
  }
}

class DemoHome extends StatefulWidget {
  @override
  _DemoHomePageState createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            MaterialButton(
              child: Text("Go Get Albums"),
              onPressed: () async {
                await NetworkClient.getAlbums();
              },
            ),
            MaterialButton(
              child: Text("Go Get Photos"),
              onPressed: () async {
                await NetworkClient.getPhotosForAlbum(3);
              },
            )
          ],
        ),
      ),
    );
  }
}
