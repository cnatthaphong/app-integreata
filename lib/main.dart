import 'package:flutter/material.dart';
import 'package:integreata2/screens/DeflectPage.dart';
import 'package:integreata2/screens/DeflectPage.dart';
import 'package:integreata2/screens/ExternalPage.dart';
import 'package:integreata2/screens/formPageTwo.dart';
import 'package:integreata2/screens/loginPage.dart';
import 'package:integreata2/screens/ConstructionPage.dart';
import 'package:integreata2/screens/StructurePage.dart';
import 'package:integreata2/screens/list-work.dart';
import 'package:integreata2/list-project.dart';

import 'package:integreata2/screens/ExteriorPage.dart';

void main() {
  runApp(const MyApp());
}

// สร้างเเอพ
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      fontFamily: 'Poppins',
    );
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightBlue[800],
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const ListProject(),
        '/listwork': (BuildContext context) => const ListWork(),
        '/constructionPage': (BuildContext context) => const ConstructionPage(),
        '/StructurePage': (BuildContext context) => const StructurePage(),
        '/DeflectPage': (BuildContext context) => const DeflectPage(),
        '/ExternalPage': (BuildContext context) => const ExternalPage(),
        '/ExteroirPage': (BuildContext context) => const ExteroirPage(),
        "/login": (BuildContext context) => const LoginPage(),
        '/formPageTwo': (BuildContext context) => const FormPageTwo()
      },
    );
  }
}
