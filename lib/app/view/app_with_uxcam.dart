import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:my_app/l10n/l10n.dart';
import 'package:my_app/router/app_router_with_uxcam.dart';

class AppWithUxcam extends StatefulWidget {
  const AppWithUxcam({super.key});

  @override
  State<AppWithUxcam> createState() => _AppWithUxcamState();
}

class _AppWithUxcamState extends State<AppWithUxcam> {
  @override
  void initState() {
    super.initState();
    unawaited(FlutterUxcam.optIntoSchematicRecordings());
    final config = FlutterUxConfig(
      userAppKey: '0n5owg7bnt8tc43-ae',
      enableAutomaticScreenNameTagging: false,
      enableIntegrationLogging: true,
      enableNetworkLogging: true,
    );
    unawaited(FlutterUxcam.startWithConfiguration(config));
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
      routerConfig: AppRouterWithUxcam.router,
    );
  }
}
