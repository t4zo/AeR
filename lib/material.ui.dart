import 'dart:async';

import 'package:AeR/stores/responsavel.store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'navigations/tab.navigation.dart';

import 'package:AeR/views/professores/acompanhamento_aulas.view.dart';

import 'package:AeR/views/responsaveis/alunos.view.dart';
import 'package:AeR/views/responsaveis/aula.view.dart';
import 'package:AeR/views/responsaveis/aulas.view.dart';

class MaterialUiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _responsavelProvider = Provider.of<ResponsavelStore>(context);

    Observable(Timer.periodic(Duration(seconds: 5), (timer) {
      if (_responsavelProvider.hasUpdate) {
        print(DateTime.now());
        _responsavelProvider.setUpdate(false);
      }
    }));

    return MaterialApp(
      title: 'Juazeiro Cidade Educadora - Aula em Rede',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(),
        AlunosView.routeName: (ctx) => AlunosView(),
        AulasView.routeName: (ctx) => AulasView(),
        AulaView.routeName: (ctx) => AulaView(),
        AcompanhamentoAulasView.routeName: (ctx) => AcompanhamentoAulasView(),
      },
      onGenerateRoute: (settings) {
        // print(settings.arguments);
        return MaterialPageRoute(
          builder: (ctx) => TabsScreen(),
        );
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (ctx) => TabsScreen(),
      ),
    );
  }
}
