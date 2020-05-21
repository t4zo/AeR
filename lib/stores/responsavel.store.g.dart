// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responsavel.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ResponsavelStore on _ResponsavelStore, Store {
  final _$_idAtom = Atom(name: '_ResponsavelStore._id');

  @override
  int get _id {
    _$_idAtom.reportRead();
    return super._id;
  }

  @override
  set _id(int value) {
    _$_idAtom.reportWrite(value, super._id, () {
      super._id = value;
    });
  }

  final _$_nomeAtom = Atom(name: '_ResponsavelStore._nome');

  @override
  String get _nome {
    _$_nomeAtom.reportRead();
    return super._nome;
  }

  @override
  set _nome(String value) {
    _$_nomeAtom.reportWrite(value, super._nome, () {
      super._nome = value;
    });
  }

  final _$_cpfAtom = Atom(name: '_ResponsavelStore._cpf');

  @override
  String get _cpf {
    _$_cpfAtom.reportRead();
    return super._cpf;
  }

  @override
  set _cpf(String value) {
    _$_cpfAtom.reportWrite(value, super._cpf, () {
      super._cpf = value;
    });
  }

  final _$_alunosAtom = Atom(name: '_ResponsavelStore._alunos');

  @override
  List<Aluno> get _alunos {
    _$_alunosAtom.reportRead();
    return super._alunos;
  }

  @override
  set _alunos(List<Aluno> value) {
    _$_alunosAtom.reportWrite(value, super._alunos, () {
      super._alunos = value;
    });
  }

  final _$_alunoAtom = Atom(name: '_ResponsavelStore._aluno');

  @override
  Aluno get _aluno {
    _$_alunoAtom.reportRead();
    return super._aluno;
  }

  @override
  set _aluno(Aluno value) {
    _$_alunoAtom.reportWrite(value, super._aluno, () {
      super._aluno = value;
    });
  }

  final _$_aulaAtom = Atom(name: '_ResponsavelStore._aula');

  @override
  Aula get _aula {
    _$_aulaAtom.reportRead();
    return super._aula;
  }

  @override
  set _aula(Aula value) {
    _$_aulaAtom.reportWrite(value, super._aula, () {
      super._aula = value;
    });
  }

  final _$_ResponsavelStoreActionController =
      ActionController(name: '_ResponsavelStore');

  @override
  void setNome(String nome) {
    final _$actionInfo = _$_ResponsavelStoreActionController.startAction(
        name: '_ResponsavelStore.setNome');
    try {
      return super.setNome(nome);
    } finally {
      _$_ResponsavelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCpf(String cpf) {
    final _$actionInfo = _$_ResponsavelStoreActionController.startAction(
        name: '_ResponsavelStore.setCpf');
    try {
      return super.setCpf(cpf);
    } finally {
      _$_ResponsavelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAlunos(List<Aluno> alunos) {
    final _$actionInfo = _$_ResponsavelStoreActionController.startAction(
        name: '_ResponsavelStore.setAlunos');
    try {
      return super.setAlunos(alunos);
    } finally {
      _$_ResponsavelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAluno(Aluno aluno) {
    final _$actionInfo = _$_ResponsavelStoreActionController.startAction(
        name: '_ResponsavelStore.setAluno');
    try {
      return super.setAluno(aluno);
    } finally {
      _$_ResponsavelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAula(Aula aula) {
    final _$actionInfo = _$_ResponsavelStoreActionController.startAction(
        name: '_ResponsavelStore.setAula');
    try {
      return super.setAula(aula);
    } finally {
      _$_ResponsavelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setResposta(String resposta) {
    final _$actionInfo = _$_ResponsavelStoreActionController.startAction(
        name: '_ResponsavelStore.setResposta');
    try {
      return super.setResposta(resposta);
    } finally {
      _$_ResponsavelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
