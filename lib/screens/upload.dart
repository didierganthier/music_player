import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  TextEditingController songName = TextEditingController();
  TextEditingController artistName = TextEditingController();

  File image, song;
  String imagePath, songPath;
  StorageReference ref;
  var image_down_url, song_down_url;
  final firestoreInstance = Firestore.instance;

  void selectImage() async{
    image = await FilePicker.getFile();

    setState(() {
      image = image;
      imagePath = basename(image.path);
      uploadImageFile(image.readAsBytesSync(), imagePath);
    });
  }

  Future<String> uploadImageFile(List<int>image, String imagePath) async {
    ref = FirebaseStorage.instance.ref().child(imagePath);
    StorageUploadTask uploadTask = ref.putData(image);

    image_down_url = await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  void selectSong() async{
    song = await FilePicker.getFile();

    setState(() {
      song = song;
      songPath = basename(song.path);
      uploadSongFile(song.readAsBytesSync(), songPath);
    });
  }

  Future<String> uploadSongFile(List<int>song, String songPath) async {
    ref = FirebaseStorage.instance.ref().child(songPath);
    StorageUploadTask uploadTask = ref.putData(song);

    song_down_url = await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  finalUpload(){
    var data = {
      'song_name': songName.text,
      'artist_name': artistName.text,
      'song_url': song_down_url.toString(),
      'image_url': image_down_url.toString()
    };

    firestoreInstance.collection("songs").document().setData(data);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: ()=> selectImage(),
            child: Text('Select Image'),
          ),
          RaisedButton(
            onPressed: ()=> selectSong(),
            child: Text('Select Song'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              controller: songName,
              decoration: InputDecoration(
                hintText: 'Enter song name'
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              controller: artistName,
              decoration: InputDecoration(
                  hintText: 'Enter artist name'
              ),
            ),
          ),
          RaisedButton(
            onPressed: ()=> finalUpload(),
            child: Text('Upload'),
          )
        ],
      ),
    );
  }
}
