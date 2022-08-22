import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/navigation/app_router.dart';
import 'features/list/display/pages/list_page.dart';
import 'generated/l10n.dart';
import 'theme/app_themes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      onGenerateRoute: generatedRoutes,
      supportedLocales: AppLocalizations.delegate.supportedLocales,
      title: 'Tyba Juan test App',
      theme: AppThemes.lightTheme,
      home: const ListPage(),
    );
  }
}
