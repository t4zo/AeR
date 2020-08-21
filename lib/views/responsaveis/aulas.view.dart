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

  bool loaded = false;

  @override
  void initState() {
    super.initState();
    final responsavelStore =
        Provider.of<ResponsavelStore>(context, listen: false);
        
    setState(() {
      _disciplinas = responsavelStore.disciplinas();
      _filterFeedback = FeedbackEnum.All;
      _filterStatus = StatusEnum.All;
    });    
  }

  void _handleChooseAula(Aula aula) {
    final responsavelStore =
        Provider.of<ResponsavelStore>(context, listen: false);

    responsavelStore.setAula(aula);

    Navigator.of(context).pushNamed(AulaView.routeName);
  }

  void _handleFilterContent() {
    final responsavelStore =
        Provider.of<ResponsavelStore>(context, listen: false);

    switch (_filterOptions) {
      case FilterOptions.AulasPendentes:
        setState(() {
          _filterFeedback = FeedbackEnum.RealizadoSemAproveitamento;
          _filterStatus = StatusEnum.Pendente;
        });
        break;
      case FilterOptions.AulasVisualizadas:
        setState(() {
          _filterFeedback = FeedbackEnum.RealizadoSemAproveitamento;
          _filterStatus = StatusEnum.Visualizada;
        });
        break;
      case FilterOptions.DesafiosRealizados:
        setState(() {
          _filterFeedback = FeedbackEnum.RealizadoComAproveitamento;
          _filterStatus = StatusEnum.All;
        });
        break;
      case FilterOptions.DesafiosNaoAvaliados:
        setState(() {
          _filterFeedback = FeedbackEnum.RealizadoSemAproveitamento;
          _filterStatus = StatusEnum.All;
        });
        break;
      default:
        setState(() {
          _filterFeedback = FeedbackEnum.All;
          _filterStatus = StatusEnum.All;
        });

        setState(() {
          _disciplinas = responsavelStore.disciplinas();
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _responsavelStore =
        Provider.of<ResponsavelStore>(context, listen: false);

    _handleFilterContent();

    return SafeArea(
      child: GestureDetector(
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
                child: const Icon(Icons.more_vert),
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
                                            style:
                                                TextStyle(color: Colors.black),
                                            children: [
                                          if (aula.status ==
                                              StatusEnum.Pendente)
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
                                          if (aula.status ==
                                              StatusEnum.Realizada)
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
                                    trailing: const Icon(Icons.forward),
                                    onTap: () => {
                                      // _verifyConnectivity(),
                                      _handleChooseAula(aula)
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ))
                    .toList()),
          ),
        ),
      ),
    );
  }
}
