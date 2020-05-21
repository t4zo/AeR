import 'package:AeR/material.ui.dart';
import 'package:AeR/stores/responsavel.store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider<ResponsavelStore>(create: (_) => ResponsavelStore()),
    ], child: MaterialUiApp());
  }
}
