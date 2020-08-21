import 'package:connectivity/connectivity.dart';
import 'package:mobx/mobx.dart';

part 'connectivity.store.g.dart';

class ConnectivityStore = _ConnectivityStore with _$ConnectivityStore;

abstract class _ConnectivityStore with Store {
  @observable
  ConnectivityResult _connectivity;

  @computed
  bool get hasConnection => _connectivity != ConnectivityResult.none;

  @action
  setConnectivity(ConnectivityResult value) => _connectivity = value;
}