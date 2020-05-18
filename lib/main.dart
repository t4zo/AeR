import 'package:AeR/stores/responsavel.store.dart';
import 'package:AeR/views/professores/acompanhamentoAulas.view.dart';
import 'package:AeR/views/responsaveis/alunos.view.dart';
import 'package:AeR/views/responsaveis/aula.view.dart';
import 'package:AeR/views/responsaveis/aulas.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AeR/navigations/tab.navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ResponsavelStore>(create: (_) => ResponsavelStore()),
      ],
    child: MaterialApp(
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
        } ,
        onGenerateRoute: (settings) {
          // print(settings.arguments);
          return MaterialPageRoute(
            builder: (ctx) => TabsScreen(),
          );
        },
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (ctx) => TabsScreen(),
        ),
    ),
    );
  }
}
