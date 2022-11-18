import 'package:go_router/go_router.dart';

import '../screens/meething_webveiw.dart';
import '../screens/navigator.dart';

class MyRouter {
  MyRouter();
  final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, GoRouterState state) {
          return NavigationScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: ':meetlink',
            builder: (context, GoRouterState state) {
              return MeetingWebView(
                meetingUrl: state.params['meetlink']!,
              );
            },
          ),
        ],
      ),
    ],
  );
}
