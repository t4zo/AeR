import 'package:AeR/models/aula.model.dart';
import 'package:AeR/stores/responsavel.store.dart';
import 'package:AeR/views/responsaveis/aula.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  All,
  AulasPendentes,
  AulasVisualizadas,
  DesafiosRealizados,
  DesafiosNaoAvaliados
}

class AulasView extends StatefulWidget {
  static const routeName = '/responsavel/alunos/aulas';

  @override
  _AulasViewState createState() => _AulasViewState();
}

class _AulasViewState extends State<AulasView> {
  Set<String> _disciplinas;
  FilterOptions _filterOptions;
  FeedbackEnum _filterFeedback;
  StatusEnum _filterStatus;

  @override
  void initState() {
    super.initState();
    final _responsavelStore =
        Provider.of<ResponsavelStore>(context, listen: false);

    setState(() {
      _disciplinas = _responsavelStore.disciplinas();
      _filterFeedback = FeedbackEnum.All;
      _filterStatus = StatusEnum.All;
    });
  }

  void _handleChooseAula(BuildContext context, Aula aula) {
    final _responsavelStore =
        Provider.of<ResponsavelStore>(context, listen: false);

    _responsavelStore.setAula(aula);

    Navigator.of(context).pushNamed(AulaView.routeName);
  }

  _handleFilterContent(ResponsavelStore _responsavelStore) {
    switch (_filterOptions) {
      case FilterOptions.AulasPendentes:
        setState(() {
          _disciplinas = _responsavelStore.disciplinas();
          _filterFeedback = FeedbackEnum.RealizadoSemAproveitamento;
          _filterStatus = StatusEnum.Pendente;
        });
        break;
      case FilterOptions.AulasVisualizadas:
        setState(() {
          _disciplinas = _responsavelStore.disciplinas();
          _filterFeedback = FeedbackEnum.RealizadoSemAproveitamento;
          _filterStatus = StatusEnum.Visualizada;
        });
        break;
      case FilterOptions.DesafiosRealizados:
        setState(() {
          _disciplinas = _responsavelStore.disciplinas();
          _filterFeedback = FeedbackEnum.RealizadoComAproveitamento;
          _filterStatus = StatusEnum.All;
        });
        break;
      case FilterOptions.DesafiosNaoAvaliados:
        setState(() {
          _disciplinas = _responsavelStore.disciplinas();
          _filterFeedback = FeedbackEnum.RealizadoSemAproveitamento;
          _filterStatus = StatusEnum.All;
        });
        break;
      default:
        setState(() {
          _disciplinas = _responsavelStore.disciplinas();
          _filterFeedback = FeedbackEnum.All;
          _filterStatus = StatusEnum.All;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _responsavelStore = Provider.of<ResponsavelStore>(context);

    _handleFilterContent(_responsavelStore);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Escolha a Aula - ${_responsavelStore.aluno.nome}'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (FilterOptions value) {
                setState(() {
                  _filterOptions = value;
                });
              },
              child: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Todas as aulas'),
                  value: FilterOptions.All,
                ),
                PopupMenuItem(
                  child: Text('Aulas Pendentes'),
                  value: FilterOptions.AulasPendentes,
                ),
                PopupMenuItem(
                  child: Text('Aulas Visualizadas'),
                  value: FilterOptions.AulasVisualizadas,
                ),
                PopupMenuItem(
                  child: Text('Desafio Realizados'),
                  value: FilterOptions.DesafiosRealizados,
                ),
                PopupMenuItem(
                  child: Text('Desafios Não Avaliados'),
                  value: FilterOptions.DesafiosNaoAvaliados,
                ),
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
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
                              .where((aula) =>
                                  _filterFeedback == aula.feedback ||
                                  _filterFeedback == FeedbackEnum.All)
                              .where((aula) =>
                                  aula.status == _filterStatus ||
                                  _filterStatus == StatusEnum.All)
                              .map(
                                (aula) => ListTile(
                                  title: Text(aula.titulo),
                                  subtitle: RichText(
                                      text: TextSpan(
                                          text: '${aula.disciplina} - ',
                                          style: TextStyle(color: Colors.black),
                                          children: [
                                        if (aula.status == StatusEnum.Pendente)
                                          TextSpan(
                                              text: aula.status
                                                  .toString()
                                                  .split('.')
                                                  .last,
                                              style: TextStyle(
                                                backgroundColor: Colors.red,
                                                color: Colors.white,
                                              )),
                                        if (aula.status ==
                                            StatusEnum.Visualizada)
                                          TextSpan(
                                              text: aula.status
                                                  .toString()
                                                  .split('.')
                                                  .last,
                                              style: TextStyle(
                                                backgroundColor: Colors.grey,
                                                color: Colors.white,
                                              )),
                                        if (aula.status == StatusEnum.Realizada)
                                          TextSpan(
                                              text: aula.status
                                                  .toString()
                                                  .split('.')
                                                  .last,
                                              style: TextStyle(
                                                backgroundColor: Colors.green,
                                                color: Colors.white,
                                              )),
                                      ])),
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
