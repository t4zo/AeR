import 'dart:io';

import 'package:AeR/stores/responsavel.store.dart';
import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:path_provider/path_provider.dart' as syspaths;

class AulaView extends StatefulWidget {
  static const routeName = '/responsavel/alunos/aulas/aula';

  @override
  _AulaViewState createState() => _AulaViewState();
}

class _AulaViewState extends State<AulaView> {
  var _videoId = '1nIKe33ZELX8nQw4DrhkQhsjhOA-R5jzb';
  bool _isLocal = false;
  bool _initialLoading = true;
  bool _loadingVideo = false;
  YoutubePlayerController _youtubePlayerController;
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    syspaths.getApplicationDocumentsDirectory().then((appDir) {
      final _file = File('${appDir.path}/videos/$_videoId.mp4');

      _file.exists().then((exists) {
        if (!exists) {
          _handleYoutubeVideo();
        } else {
          _handleLocalVideo(_file);
          setState(() {
            _isLocal = true;
            _initialLoading = false;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_isLocal == true) {
      _videoPlayerController.dispose();
      _chewieController.dispose();
    }
  }

  void _handleYoutubeVideo() {
    final _responsavelStore =
        Provider.of<ResponsavelStore>(context, listen: false);

    final videoId = _responsavelStore.aula.url.split('?v=')[1];
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );

    setState(() {
      _isLocal = false;
      _initialLoading = false;
    });
  }

  void _handleLocalVideo(File video) {
    final videoPlayerController = VideoPlayerController.file(video)
      ..initialize().then((_) {});
    final chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: false,
      looping: false,
    );

    setState(() {
      _videoPlayerController = videoPlayerController;
      _chewieController = chewieController;
    });
  }

  Future _handleDownload() async {
    final _aplicationFilesDirectory =
        await syspaths.getApplicationDocumentsDirectory();
    final _directory = Directory('${_aplicationFilesDirectory.path}/videos/');
    Directory _dirAeR;

    if (await _directory.exists()) {
      _dirAeR = _directory;
    } else {
      _dirAeR = await _directory.create();
    }
    final _video = '${_dirAeR.path}/$_videoId.mp4';

    setState(() {
      _loadingVideo = true;
    });

    await Dio().download(
        'https://drive.google.com/u/0/uc?id=$_videoId&export=download',
        '$_video');

    _handleLocalVideo(File(_video));

    setState(() {
      _isLocal = true;
      _loadingVideo = false;
    });

    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Download do vídeo'),
              content: Text('Vídeo baixado com sucesso!'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Continuar'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ));
  }

  Future _handleDelete(BuildContext ctx) async {
    try {
      final app = await syspaths.getApplicationDocumentsDirectory();
      final videoPath = '${app.path}/videos/$_videoId.mp4';
      final video = File(videoPath);

      setState(() {
        _loadingVideo = true;
      });

      await video.delete();

      _handleYoutubeVideo();

      setState(() {
        _isLocal = false;
        _loadingVideo = false;
      });

      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text('Vídeo removido com sucesso!'),
        duration: const Duration(seconds: 2),
        // action: SnackBarAction(
        //   label: 'Fechar',
        //   onPressed: () {},
        // )),
      ));
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _responsavelStore =
        Provider.of<ResponsavelStore>(context, listen: false);

    final appBar = AppBar(
      title: Text(_responsavelStore.aula.titulo),
      actions: <Widget>[
        _loadingVideo
            ? Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: SizedBox(
                    child: const CircularProgressIndicator(strokeWidth: 3)),
              )
            : Builder(
                builder: (ctx) => IconButton(
                  icon: Icon(
                      _isLocal == true ? Icons.delete : Icons.file_download),
                  onPressed: _isLocal == true
                      ? () => _handleDelete(ctx)
                      : _handleDownload,
                ),
              )
      ],
    );

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: _initialLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).viewPadding.top -
                        appBar.preferredSize.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: _isLocal == true
                              ? Chewie(controller: _chewieController)
                              : YoutubePlayer(
                                  controller: _youtubePlayerController,
                                  showVideoProgressIndicator: true,
                                  progressIndicatorColor:
                                      Theme.of(context).primaryColor,
                                  progressColors: ProgressBarColors(
                                    playedColor: Colors.amber,
                                    handleColor: Colors.amberAccent,
                                  ),
                                ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.1),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  _responsavelStore.aula.desafio,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Digite aqui a sua resposta',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.zero)),
                                  ),
                                  minLines: 10,
                                  maxLines: 20,
                                ),
                              ]),
                        ),
                        Container(
                          width: double.infinity,
                          child: RaisedButton.icon(
                            icon: Icon(Icons.save),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            label: const Text('Enviar'),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.zero)),
                            elevation: 0,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
