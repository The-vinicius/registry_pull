import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:registry_pull/l10n/app_localizations.dart';
import 'package:registry_pull/routes.dart';
import 'package:routefly/routefly.dart';
import 'package:upgrader/upgrader.dart';

class AppRegistry extends StatelessWidget {
  const AppRegistry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Registry pull',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('pt'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) {
          return const Locale('en');
        }
        if (locale.languageCode == 'pt') {
          return const Locale('pt');
        }
        return const Locale('en');
      },
      builder: (context, child) {
        return UpgradeAlert(
          showIgnore: false,
          child: child!,
        );
      },
      routerConfig:
          Routefly.routerConfig(routes: routes, initialPath: routePaths.splash),
    );
  }
}
