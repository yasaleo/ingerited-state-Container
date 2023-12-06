import 'package:flutter/material.dart';
import 'package:inherited_state_container/screens/add_edit_screen.dart';
import 'package:inherited_state_container/screens/home_screen.dart';

import 'core/localization.dart';
import 'core/routes.dart';
import 'localization.dart';


class InheritedWidgetApp extends StatelessWidget {
  const InheritedWidgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      onGenerateTitle: (context) =>
          InheritedWidgetLocalizations.of(context)?.appTitle??'',
      // theme: ArchSampleTheme.theme,
      localizationsDelegates: [
        ArchSampleLocalizationsDelegate(),
        InheritedWidgetLocalizationsDelegate(),
      ],
      routes: {
        ArchSampleRoutes.home: (context) => const HomeScreen(),
        ArchSampleRoutes.addTodo: (context) => AddEditScreen(),
      },
    );
  }
}
