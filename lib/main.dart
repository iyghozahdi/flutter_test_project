import 'package:flutter/material.dart';
import 'package:flutter_test_project/provider/auth_provider.dart';
import 'package:flutter_test_project/views/home/home.dart';
import 'package:flutter_test_project/views/login/login.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDirDoc = await getApplicationDocumentsDirectory();
  String dbPath = '${appDirDoc.path}/omnichannel.db';
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database db = await dbFactory.openDatabase(dbPath);
  GetIt.I.registerSingleton(db);
  await AuthProvider.instance.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider.instance),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final isLogin = authProvider.isLogin;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: isLogin ? Home() : LoginPage(),
    );
  }
}
