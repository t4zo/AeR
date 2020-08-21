import 'package:flutter/material.dart';

class GlobalScaffold {
  static final GlobalScaffold instance = GlobalScaffold();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackBar(SnackBar snackBar) {
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}