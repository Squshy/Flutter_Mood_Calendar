import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:mood/views/changePassword/changePassword.dart';
import 'package:mood/views/data_chart_and_bar/data_bar.dart';
import 'package:mood/views/data_chart_and_bar/data_chart.dart';
import 'package:mood/views/settings/language/language_settings.dart';
import 'package:mood/views/waiting_screen/waiting_screen.dart';
import 'package:provider/provider.dart';
import './views/login/login.dart';
import './views/Map/map.dart';
// Views
import './views/home/home.dart';
import './theme.dart';
import './views/mood/select_mood.dart';
import './views/calendar/calendar.dart';
import './views/settings/settings.dart';
import 'views/settings/color/color_settings.dart';
import './views/selected_day/selected_days_mood.dart';
import './views/loading_screen/loading_screen.dart';
import 'package:mood/views/mood/select_mood.dart';
// Store
import './model/store/user.dart';
import './model/store/mood.dart';

void main() {
  // Internationalization settings
  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
        useCountryCode: false,
        fallbackFile: 'en',
        basePath: 'assets/flutter_i18n'),
  );
  WidgetsFlutterBinding.ensureInitialized();
  flutterI18nDelegate.load(null);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserBLoC()),
        ChangeNotifierProvider(create: (_) => MoodBLoC())
      ],
      child: MaterialApp(
            title: 'Mobile Baller Squad Mood App',
            theme: customTheme,
            home: LoadingScreen(),
            routes: <String, WidgetBuilder> {
              //list of routes
              '/selectMood': (BuildContext context) => SelectMood(),
              '/calendar': (BuildContext context) => Calendar(),
              '/home': (BuildContext context) => Home(),
              '/login': (BuildContext context) => Login(),
              '/settings': (BuildContext context) => Settings(),
              '/colorSettings': (BuildContext context) => ColorSettings(),
              '/languageSettings': (BuildContext context) => LanguageSettings(),
              '/selectedDaysMood': (BuildContext context) => SelectedDaysMood(),
              '/waitingScreen': (BuildContext context) => WaitingScreen(),
              '/moodChart': (BuildContext context) => MoodDataChart(),
              '/moodBar': (BuildContext context) => MoodDataBar(),
              '/map': (BuildContext context) => Map(),
              '/changePassword': (BuildContext context) => ChangePassword(),
            },
            localizationsDelegates: [ // delegates for internationalization
              flutterI18nDelegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ]
          ),

    ),
  );
}
