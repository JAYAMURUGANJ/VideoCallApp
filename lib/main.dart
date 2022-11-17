import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tringtring/meething_webveiw.dart';
import 'navigator.dart';

void main() => runApp(const MyApp());

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return NavigationScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: ':meetlink',
          builder: (BuildContext context, GoRouterState state) {
            return MeetingWebView(
              meetingUrl: state.params['meetlink']!,
            );
          },
        ),
      ],
    ),
  ],
);

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
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}
