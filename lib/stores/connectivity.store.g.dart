// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConnectivityStore on _ConnectivityStore, Store {
  Computed<bool> _$hasConnectionComputed;

  @override
  bool get hasConnection =>
      (_$hasConnectionComputed ??= Computed<bool>(() => super.hasConnection,
              name: '_ConnectivityStore.hasConnection'))
          .value;

  final _$_connectivityAtom = Atom(name: '_ConnectivityStore._connectivity');

  @override
  ConnectivityResult get _connectivity {
    _$_connectivityAtom.reportRead();
    return super._connectivity;
  }

  @override
  set _connectivity(ConnectivityResult value) {
    _$_connectivityAtom.reportWrite(value, super._connectivity, () {
      super._connectivity = value;
    });
  }

  final _$_ConnectivityStoreActionController =
      ActionController(name: '_ConnectivityStore');

  @override
  dynamic setConnectivity(ConnectivityResult value) {
    final _$actionInfo = _$_ConnectivityStoreActionController.startAction(
        name: '_ConnectivityStore.setConnectivity');
    try {
      return super.setConnectivity(value);
    } finally {
      _$_ConnectivityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hasConnection: ${hasConnection}
    ''';
  }
}
