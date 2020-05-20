import 'package:AeR/models/aluno.model.dart';
import 'package:AeR/models/aula.model.dart';
import 'package:mobx/mobx.dart';

part 'responsavel.store.g.dart';

class ResponsavelStore = _ResponsavelStore with _$ResponsavelStore;

abstract class _ResponsavelStore with Store {
  @observable
  String _nome = 'Tácio de Souza Campos';

  @observable
  String _cpf = '05962142519';

  @observable
  List<Aluno> _alunos = [
    Aluno(
      id: 1,
      nome: 'Marcela Batista',
      escolaId: 1,
      escola: '02 DE JULHO',
      serieId: 8,
      serie: '2º Ano',
      turnoId: 1,
      turno: 'Manhã',
      aulas: [
        Aula(
          id: 1,
          titulo: 'Título da Aula 01',
          disciplinaId: 1,
          disciplina: 'Português',
          desafio: 'Escreva o alfabeto de A à Z',
          status: StatusEnum.Visualizada,
          resposta: '',
          feedback: FeedbackEnum.RealizadoSemAproveitamento,
          url: 'https://www.youtube.com/embed/watch?v=hJ_dcDN1bgw',
        ),
        Aula(
          id: 2,
          titulo: 'Título da Aula 02',
          disciplinaId: 2,
          disciplina: 'Matemática',
          desafio: 'Escreva os número de 1 a 10',
          status: StatusEnum.Realizada,
          resposta: '1, 2, 3, 4, 5, 6, 7, 8, 9 e 10.',
          feedback: FeedbackEnum.RealizadoComAproveitamento,
          url: 'https://www.youtube.com/embed/watch?v=hJ_dcDN1bgw',
        ),
        Aula(
          id: 3,
          titulo: 'Título da Aula 03',
          disciplinaId: 3,
          disciplina: 'Ciências',
          desafio: 'Escreva o nome de um mamífero',
          status: StatusEnum.Realizada,
          resposta: 'Cobra',
          feedback: FeedbackEnum.RealizadoSemAproveitamento,
          url: 'https://www.youtube.com/embed/watch?v=hJ_dcDN1bgw',
        ),
        Aula(
          id: 4,
          titulo: 'Título da Aula 04',
          disciplinaId: 2,
          disciplina: 'Matemática',
          desafio: 'Escreva os número de 2 a 20',
          status: StatusEnum.Pendente,
          resposta: '',
          feedback: FeedbackEnum.RealizadoSemAproveitamento,
          url: 'https://www.youtube.com/embed/watch?v=hJ_dcDN1bgw',
        ),
      ],
    ),
    Aluno(
      id: 2,
      nome: 'Talita Carvalho',
      escolaId: 2,
      escola: '15 DE JULHO',
      serieId: 9,
      serie: '3º Ano',
      turnoId: 2,
      turno: 'Tarde',
      aulas: [
        Aula(
          id: 5,
          titulo: 'Título da Aula 05',
          disciplinaId: 2,
          disciplina: 'Matemática',
          desafio: 'Escreva os número de 1 a 10',
          status: StatusEnum.Realizada,
          resposta: '1, 2, 3, 4, 5, 6, 7, 8, 9 e 10.',
          feedback: FeedbackEnum.RealizadoComAproveitamento,
          url: 'https://www.youtube.com/embed/watch?v=hJ_dcDN1bgw',
        )
      ],
    )
  ];

  @observable
  Aluno _aluno;

  @observable
  Aula _aula;

  Set<String> disciplinas() => _aluno.aulas.map((aula) => aula.disciplina).toSet();

  Set<String> aulasPendentes(int disciplinaId) {
    final aulas = _aluno.aulas
        .where((aula) => aula.status == StatusEnum.Pendente)
        .where((aula) => aula.disciplinaId == disciplinaId)
        .map((aula) => aula.disciplina)
        .toSet();
    return aulas;
  }

  String get nome => _nome.toString();

  String get cpf => _cpf.toString();

  List<Aluno> get alunos => [..._alunos];

  Aluno get aluno => _aluno;

  Aula get aula => _aula;

  bool get hasAluno => _aluno != null;

  bool get hasAula => _aula != null;

  @action
  void setNome(String nome) => _nome = nome;

  @action
  void setCpf(String cpf) => _cpf = cpf;

  @action
  void setAlunos(List<Aluno> alunos) => _alunos = alunos;

  @action
  void setAluno(Aluno aluno) => _aluno = aluno;

  @action
  void setAula(Aula aula) => _aula = aula;
}
