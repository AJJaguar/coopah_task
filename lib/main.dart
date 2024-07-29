import 'package:coopah_task/features/Sample/presentation/pages/Sample_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            // primary:  Color(0XFFFF5700),
            seedColor: const Color(0XFFFF5700)),
        fontFamily: 'CircularStd',
        useMaterial3: true,
      ),
      home: SamplePage(),
    );
  }
}
