import 'package:AeR/database/helper.dart';
import 'package:AeR/setting.dart';
import 'package:AeR/stores/responsavel.store.dart';

class ResponsavelRepository {
  // void add(Responsavel responsavel) {
  void add(ResponsavelStore responsavelStore) {
    DBHelper.insert(TBL_RESPONSAVEIS, {
      'id': responsavelStore.id,
      'nome': responsavelStore.nome,
      'cpf': responsavelStore.cpf,
    });
    DBHelper.insert(TBL_ALUNOS, {
      'id': responsavelStore.aluno.id,
      'responsavelId': responsavelStore.id,
      'nome': responsavelStore.aluno.nome,
      'escolaId': responsavelStore.aluno.escolaId,
      'escola': responsavelStore.aluno.escola,
      'serieId': responsavelStore.aluno.serieId,
      'serie': responsavelStore.aluno.serie,
      'turnoId': responsavelStore.aluno.turnoId,
      'turno': responsavelStore.aluno.turno,
    });
    DBHelper.insert(TBL_AULAS, {
      'id': responsavelStore.aula.id,
      'alunoId': responsavelStore.aluno.id,
      'disciplinaId': responsavelStore.aula.disciplinaId,
      'disciplina': responsavelStore.aula.disciplina,
      'titulo': responsavelStore.aula.titulo,
      'status': responsavelStore.aula.status.toString().split('.').last,
      'desafio': responsavelStore.aula.desafio,
      'resposta': responsavelStore.aula.resposta,
      'feedback': responsavelStore.aula.feedback.toString().split('.').last,
      'url': responsavelStore.aula.url,
    });
  }
}
