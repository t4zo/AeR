enum Status { Pendente, Visualizada, Realizada }
enum Feedback { RealizadoComAproveitamento, RealizadoSemAproveitamento }

class Aula {
  int id;
  int disciplinaId;
  String disciplina;
  String titulo;
  Status status;
  String desafio;
  String resposta;
  Feedback feedback;
  String url;

  Aula({
    this.id,
    this.disciplinaId,
    this.disciplina,
    this.titulo,
    this.status,
    this.desafio,
    this.resposta,
    this.feedback,
    this.url,
  });

  Aula.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    disciplinaId = double.parse(json['disciplinaId']).toInt();
    disciplina = json['disciplina'];
    titulo = json['titulo'];
    status = json['status'].cast<String>();
    desafio = json['desafio'];
    resposta = json['resposta'];
    feedback = json['feedback'].cast<String>();
    url = json['url'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['disciplinaId'] = this.disciplinaId;
    data['disciplina'] = this.disciplina;
    data['titulo'] = this.titulo;
    data['status'] = this.status;
    data['desafio'] = this.desafio;
    data['resposta'] = this.resposta;
    data['feedback'] = this.feedback;
    data['url'] = this.url;
    return data;
  }
}
