import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kampus_sggw/logic/histories/search_history.dart';
import 'package:kampus_sggw/logic/histories/visit_history.dart';
import 'package:kampus_sggw/models/map_items.dart';
import 'package:kampus_sggw/screens/map_screen/map_screen.dart';
import 'package:kampus_sggw/themes/dark_theme.dart';
import 'package:kampus_sggw/themes/light_theme.dart';
import 'package:kampus_sggw/translations/codegen_loader.g.dart';
import 'package:kampus_sggw/updateLocalData.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

var darkTheme = DarkTheme().theme;
var lightTheme = LightTheme().theme;
enum ThemeType { Light, Dark }
var darkMode = 1;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();

  await checkUpdates();

  //Map<String, dynamic> mapItemsMap = jsonDecode(MapItems.getJsonSting());
  //final mapItems = MapItems.fromJson(mapItemsMap);
  final mapItems = await MapItems.load();
  //mapItems.generateFuzzyStringSetForMapItems();

  final searchHistory = await SearchHistory.loadFromJSON();

  final visitHistory = await VisitHistory.loadFromJSON();

  final prefs = await SharedPreferences.getInstance();
  darkMode = prefs.getInt('isDarkModeOn') ?? 1;

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('pl')],
      path: 'assets/translations',
      fallbackLocale: Locale('pl'),
      startLocale: Locale('pl'),
      assetLoader: CodegenLoader(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeModel>(
            create: (context) => ThemeModel(),
          ),
          ChangeNotifierProvider.value(value: mapItems),
          ChangeNotifierProvider.value(value: searchHistory),
          ChangeNotifierProvider.value(value: visitHistory),
        ],
        child: CampusSGGW(),
      ),
    ),
  );
}

class CampusSGGW extends StatefulWidget {
  const CampusSGGW({
    Key key,
  }) : super(key: key);

  @override
  _CampusSGGWState createState() => _CampusSGGWState();
}

class _CampusSGGWState extends State<CampusSGGW> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Kampus SGGW',
      theme: Provider.of<ThemeModel>(context).currentTheme,
      home: MapScreen(),
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
    );
  }
}

// class ThemeModel extends ChangeNotifier {
//   ThemeData currentTheme = darkMode == 1 ? darkTheme : lightTheme;
//   ThemeType _themeType = darkMode == 1 ? ThemeType.Dark : ThemeType.Light;

//   toggleTheme() {
//     if (_themeType == ThemeType.Dark) {
//       currentTheme = lightTheme;
//       _themeType = ThemeType.Light;
//     } else if (_themeType == ThemeType.Light) {
//       currentTheme = darkTheme;
//       _themeType = ThemeType.Dark;
//     }

//     return notifyListeners();
//   }
// }
