import 'package:AeR/models/aluno.model.dart';

class Responsavel {
  int id;
  String nome;
  String cpf;
  List<Aluno> alunos;

  Responsavel({this.id, this.nome, this.cpf, this.alunos});

  Responsavel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    cpf = json['cpf'];
    if (json['alunos'] != null) {
      alunos = new List<Aluno>();
      json['alunos'].forEach((v) {
        alunos.add(new Aluno.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    if (this.alunos != null) {
      data['alunos'] = this.alunos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


