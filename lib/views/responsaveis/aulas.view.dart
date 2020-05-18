import 'package:AeR/models/aula.model.dart';
import 'package:AeR/stores/responsavel.store.dart';
import 'package:AeR/views/responsaveis/aula.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AulasView extends StatelessWidget {
  static const routeName = '/responsavel/alunos/aulas';

  void _handleChooseAula(BuildContext context, Aula aula) {
    final _responsavelStore =
        Provider.of<ResponsavelStore>(context, listen: false);
    
    _responsavelStore.setAula(aula);

    Navigator.of(context).pushNamed(AulaView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final _responsavelStore =
        Provider.of<ResponsavelStore>(context, listen: false);

    final _disciplinas =
        _responsavelStore.aluno.aulas.map((aula) => aula.disciplina).toSet();

    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha a Aula - ${_responsavelStore.aluno.nome}'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              children: _disciplinas
                  .map((disciplina) => Container(
                        margin: const EdgeInsets.all(10),
                        child: ExpansionTile(
                          title: Text(
                            disciplina,
                            style: TextStyle(color: Colors.black),
                          ),
                          children: _responsavelStore.aluno.aulas
                              .where((aula) => aula.disciplina == disciplina)
                              .map(
                                (aula) => ListTile(
                                  title: Text(aula.titulo),
                                  subtitle: Text(aula.disciplina),
                                  trailing: Icon(Icons.forward),
                                  onTap: () => _handleChooseAula(context, aula),
                                ),
                              )
                              .toList(),
                        ),
                      ))
                  .toList()),
        ),
      ),
    );
  }
}
