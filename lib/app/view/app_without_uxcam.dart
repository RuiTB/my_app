import 'package:flutter/material.dart';
import 'package:my_app/l10n/l10n.dart';
import 'package:my_app/router/app_router_without_uxcam.dart';

class AppWithoutUxcam extends StatefulWidget {
  const AppWithoutUxcam({super.key});

  @override
  State<AppWithoutUxcam> createState() => _AppWithoutUxcamState();
}

class _AppWithoutUxcamState extends State<AppWithoutUxcam> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: AppRouterWithoutUxcam.router,
    );
  }
}
