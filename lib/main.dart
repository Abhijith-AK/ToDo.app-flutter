import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{

  //intialise hive 

  await Hive.initFlutter();

  //open box

  var _box = await Hive.openBox('MyBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo',
      theme: ThemeData(fontFamily: 'Urbanist', ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHome(),
      },
    );
  }
}


