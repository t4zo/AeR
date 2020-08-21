import 'dart:async';

import 'package:AeR/stores/connectivity.store.dart';
import 'package:AeR/views/responsaveis/alunos.view.dart';
import 'package:AeR/widgets/globalscaffold.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResponsavelView extends StatefulWidget {
  @override
  ResponsavelViewState createState() => ResponsavelViewState();
}

class ResponsavelViewState extends State<ResponsavelView> {
  final _form = GlobalKey<FormState>();
  StreamSubscription<ConnectivityResult> subscription;

  String cpf = '';
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      Provider.of<ConnectivityStore>(context, listen: false)
          .setConnectivity(result);
      print(result);
      if (!Provider.of<ConnectivityStore>(context, listen: false)
          .hasConnection) {
        GlobalScaffold.instance.showSnackBar(SnackBar(
          content: Text(
            'Sem acesso a internet',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          // duration: Duration(days: 365),
        ));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  Future _handleSignIn(BuildContext context) async {
    setState(() {
      _busy = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _busy = false;
      });

      return Navigator.of(context).pushNamed(AlunosView.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  56,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/logo.png',
                          scale: 4,
                          semanticLabel: 'Logo SACA',
                        ),
                        const SizedBox(height: 20),
                        const Text('Juazeiro Cidade Educadora - Aula em Rede'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.15),
                    child: Form(
                      key: _form,
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          labelText: 'CPF do Responsável',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Por favor, insira o CPF do responsável';
                          return null;
                        },
                        onSaved: (value) => cpf = value,
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: _busy
                        ? SizedBox(
                            height: 15,
                            child:
                                const CircularProgressIndicator(strokeWidth: 3),
                          )
                        : const Text('Entrar'),
                    elevation: 2,
                    color: Theme.of(context).primaryColor,
                    textColor:
                        Theme.of(context).primaryTextTheme.headline6.color,
                    onPressed: () => _handleSignIn(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
