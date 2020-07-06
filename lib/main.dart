import 'package:flutter/material.dart';
import 'package:musicplayer/screens/home.dart';
import 'package:musicplayer/screens/upload.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;

  List tabs = [
    Home(),
    Upload()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player App',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Music Player App'),
        ),
        body: tabs[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.cloud_upload),
                title: Text('Upload')
            ),
          ],
          onTap: (index){
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
