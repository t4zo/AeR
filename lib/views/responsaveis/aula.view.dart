import 'package:AeR/stores/responsavel.store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AulaView extends StatelessWidget {
  static const routeName = '/responsavel/alunos/aulas/aula';

  @override
  Widget build(BuildContext context) {
    final _responsavelStore =
        Provider.of<ResponsavelStore>(context, listen: false);

    final appBar = AppBar(
      title: Text(_responsavelStore.aula.titulo),
    );

    final videoId = _responsavelStore.aula.url.split('?v=')[1];

    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewPadding.top -
                  appBar.preferredSize.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Theme.of(context).primaryColor,
                      progressColors: ProgressBarColors(
                        playedColor: Colors.amber,
                        handleColor: Colors.amberAccent,
                      ),
                      // onReady: () => _controller.addListener(listener),
                    ),
                    // child: Text('Vídeo'),
                    // child: Image.network(_responsavelStore.aula.url),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
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
                                  borderRadius: BorderRadius.all(Radius.zero)),
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
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
