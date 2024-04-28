import 'package:flutter/material.dart';
import 'package:todoappvb/ui/view/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: false,
          colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: Colors.deepPurple.shade400,
              onPrimary: Colors.white,
              secondary: Colors.deepPurple.shade400,
              onSecondary: Colors.white,
              error: Colors.red,
              onError: Colors.red,
              background: Colors.white,
              onBackground: Colors.white,
              surface: Colors.deepPurple.shade400,
              onSurface: Colors.white)),
      initialRoute: "/",
      routes: {"/": (context) => const HomeView()},
      title: 'Flutter Demo',
    );
  }
}
