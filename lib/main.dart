import 'package:flutter/material.dart';
import 'package:flutterpractical/providers/user_provider.dart';
import 'package:flutterpractical/screens/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UserProvider(),
    child: MaterialApp(
      title: 'Ballers List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    )
    );
  }
}
