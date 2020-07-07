import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  TextEditingController songName = TextEditingController();
  TextEditingController artistName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: (){},
            child: Text('Select Image'),
          ),
          RaisedButton(
            onPressed: (){},
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
            onPressed: (){},
            child: Text('Upload'),
          )
        ],
      ),
    );
  }
}
