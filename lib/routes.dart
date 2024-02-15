import 'package:routefly/routefly.dart';

import 'app/(public)/splash_page.dart' as a0;

List<RouteEntity> get routes => [
  RouteEntity(
    key: '/splash',
    uri: Uri.parse('/splash'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a0.SplashPage(),
    ),
  ),
];

const routePaths = (
  path: '/',
  splash: '/splash',
);
