import 'package:flutter/material.dart';
import 'package:AeR/views/professores/acompanhamentoAulas.view.dart';

class ProfessorView extends StatefulWidget {
  @override
  ProfessorViewState createState() => ProfessorViewState();
}

class ProfessorViewState extends State<ProfessorView> {
  final _form = GlobalKey<FormState>();

  String senha = '';
  bool _busy = false;

  Future _handleSignIn(BuildContext context) async {
    setState(() {
      _busy = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _busy = false;
      });

      return Navigator.of(context).pushNamed(AcompanhamentoAulasView.routeName);
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
                          labelText: 'Senha do Professor',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Por favor, insira sua senha';
                          return null;
                        },
                        onSaved: (value) => senha = value,
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
