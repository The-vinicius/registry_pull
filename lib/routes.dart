import 'package:routefly/routefly.dart';

import 'app/(public)/home_page.dart' as a1;
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
  RouteEntity(
    key: '/home',
    uri: Uri.parse('/home'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a1.HomePage(),
    ),
  ),
];

const routePaths = (
  path: '/',
  splash: '/splash',
  home: '/home',
);
