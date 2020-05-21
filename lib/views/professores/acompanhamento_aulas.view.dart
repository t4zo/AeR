import 'package:flutter/material.dart';

class AcompanhamentoAulasView extends StatelessWidget {
  static const routeName = '/professores/acompanhamentoAulas';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Acompanhamento das Aulas'),
        ),
        body: Center(
          child: const Text('Acompanhamento de Aulas'),
        ),
      ),
    );
  }
}
