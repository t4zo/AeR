import 'package:AeR/models/aula.model.dart';

class Aluno {
  int id;
  String nome;
  int escolaId;
  String escola;
  int serieId;
  String serie;
  int turnoId;
  String turno;
  List<Aula> aulas;

  Aluno({this.id, this.nome, this.escolaId, this.escola, this.serieId, this.serie, this.turnoId, this.turno, this.aulas});

  Aluno.fromJson(Map<String, dynamic> json) {
    id = double.parse(json['nome']).toInt();
    nome = json['nome'];
    escolaId = double.parse(json['escolaId']).toInt();
    escola = json['escola'];
    serieId = double.parse(json['serieId']).toInt();
    serie = json['serie'];
    turnoId = double.parse(json['turnoId']).toInt();
    turno = json['turno'];
    if (json['aulas'] != null) {
      aulas = new List<Aula>();
      json['aulas'].forEach((v) {
        aulas.add(new Aula.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['escolaId'] = this.escolaId;
    data['escola'] = this.escola;
    data['serieId'] = this.serieId;
    data['serie'] = this.serie;
    data['turnoId'] = this.turnoId;
    data['turno'] = this.turno;
    if (this.aulas != null) {
      data['aulas'] = this.aulas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
