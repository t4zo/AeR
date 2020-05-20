import 'package:AeR/views/responsaveis/alunos.view.dart';
import 'package:flutter/material.dart';

class ResponsavelView extends StatefulWidget {
  @override
  ResponsavelViewState createState() => ResponsavelViewState();
}

class ResponsavelViewState extends State<ResponsavelView> {
  final _form = GlobalKey<FormState>();

  String cpf = '';
  bool _busy = false;

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
