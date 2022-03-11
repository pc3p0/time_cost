import 'package:flutter/material.dart';

import 'module/content_view.dart';

void main() {
  runApp(const AppRoot());
}

/// All of us are worth more than our jobs or careers! Money should be seen as a tool, not a prize.
class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Time',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const ContentView(),
      },
    );
  }
}