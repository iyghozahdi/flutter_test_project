import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';

class AuthProvider extends ChangeNotifier {
  static final instance = AuthProvider();

  final _db = GetIt.I.get<Database>();
  final _store = StoreRef.main();

  String? _token;
  String _password = "asd";

  Future<void> init() async {
    _token = await _store.record('token').get(_db) as dynamic;
    await _store.record('password').put(_db, "asd");
    _password = await _store.record('password').get(_db) as dynamic;
  }

  bool get isLogin => _token != null;

  String get getPassword => _password;

  Future<void> setLoginData({String? token}) async {
    _token = token;
    await _store.record('token').put(_db, token);
    notifyListeners();
  }

  Future<void> changePassword({String? password}) async {
    _password = password!;
    await _store.record('password').put(_db, password);
    notifyListeners();
  }

  Future<void> logOut() async {
    await _store.records(['token']).delete(_db);
    notifyListeners();
  }
}
