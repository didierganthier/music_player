import 'package:flutter/material.dart';
import 'package:music_player/music_player.dart';

class SongsPage extends StatefulWidget {
  final String song_name, artist_name, song_url, image_url;

  SongsPage({this.song_name, this.artist_name, this.song_url, this.image_url});

  @override
  _SongsPageState createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  MusicPlayer musicPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    musicPlayer = MusicPlayer();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Song will stop playing'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () {
                  musicPlayer.stop();
                  Navigator.of(context).pop(true);
                },
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.song_name),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Text(widget.artist_name, style: TextStyle(fontSize: 25.0)),
              SizedBox(
                height: 15.0,
              ),
              Text(widget.song_name, style: TextStyle(fontSize: 15.0)),
              Card(
                child: Image.network(
                  widget.image_url,
                  height: 350.0,
                ),
                elevation: 10.0,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.2,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 100.0,
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        musicPlayer.play(
                          MusicItem(
                            url: widget.song_url,
                            trackName: widget.song_name,
                            artistName: widget.artist_name,
                            albumName: 'unknown',
                            duration: Duration(seconds: 255),
                          ),
                        );
                        setState(() {
                          isPlaying = true;
                        });
                      },
                      child: Icon(
                        Icons.play_arrow,
                        size: 50.0,
                        color: isPlaying == true
                            ? Colors.lightBlueAccent
                            : Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        musicPlayer.stop();
                        setState(() {
                          isPlaying = false;
                        });
                      },
                      child: Icon(
                        Icons.stop,
                        size: 50.0,
                        color: isPlaying == true
                        ? Colors.black
                        : Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100.0,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
