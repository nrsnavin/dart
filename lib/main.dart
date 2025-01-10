import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/find_locale.dart';


import 'package:intl/date_symbol_data_local.dart';


import 'src/features/authentication/screens/home.dart';
import 'src/features/authentication/screens/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting(await findSystemLocale(), null)
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Flutter Demo',
      home: Login(),
    );
  }
}
