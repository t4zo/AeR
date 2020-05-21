import 'package:AeR/models/aluno.model.dart';
import 'package:AeR/stores/responsavel.store.dart';
import 'package:AeR/views/responsaveis/aulas.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlunosView extends StatelessWidget {
  static const routeName = '/responsavel/alunos';

  void _handleChooseAluno(BuildContext context, Aluno aluno) {
    final responsavelStore =
        Provider.of<ResponsavelStore>(context, listen: false);

    responsavelStore.setAluno(aluno);

    Navigator.of(context).pushNamed(AulasView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final _responsavelStore =
        Provider.of<ResponsavelStore>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Escolha o Aluno'),
        ),
        body: _responsavelStore.alunos.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: _responsavelStore.alunos
                      .map((aluno) => Container(
                            margin: const EdgeInsets.all(10),
                            child: Card(
                              child: ListTile(
                                title: Text(aluno.nome),
                                trailing: const Icon(Icons.forward),
                                subtitle:
                                    Text('${aluno.escola} - ${aluno.serie}'),
                                onTap: () => _handleChooseAluno(context, aluno),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
      ),
    );
  }
}
