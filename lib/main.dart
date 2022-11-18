import 'package:flutter/material.dart';
import 'package:tringtring/utils/route_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primaryColor: Colors.green,
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Colors.grey,
          cursorColor: Color.fromARGB(255, 18, 59, 39),
          selectionHandleColor: Color.fromARGB(255, 8, 175, 125),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple))),
        backgroundColor: Colors.white10,
        brightness: Brightness.light,
        highlightColor: Colors.white,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color.fromARGB(255, 8, 175, 125),
            focusColor: Colors.greenAccent,
            splashColor: Colors.lightGreen),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      routeInformationProvider: MyRouter().router.routeInformationProvider,
      routeInformationParser: MyRouter().router.routeInformationParser,
      routerDelegate: MyRouter().router.routerDelegate,
    );
  }
}
