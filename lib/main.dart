import 'package:flutter/material.dart';
import 'package:theme_switch_bloc/services/theme_service.dart';
import 'package:theme_switch_bloc/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeDatabaseService.checkDatabaseExists();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
