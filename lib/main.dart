import 'package:makeitdark/routes/custom_route.dart';
import 'package:makeitdark/models/app_theme.dart';
import 'package:makeitdark/models/game.dart';
import 'package:makeitdark/models/game_field.dart';
import 'package:makeitdark/models/levels.dart';
import 'package:makeitdark/routes/routes.dart';
import 'package:makeitdark/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppTheme(),
        ),
        ChangeNotifierProvider(
          create: (context) => GameField(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<GameField, Game>(
          create: (context) => Game(Levels.allLevels),
          update: (context, gameField, previousGame) =>
              previousGame!..gameField = gameField,
          lazy: false,
        ),
      ],
      child: const MakeItDarkApp(),
    );
  }
}

class MakeItDarkApp extends StatelessWidget {
  const MakeItDarkApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, appTheme, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '[make it dark]',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          scaffoldBackgroundColor: appTheme.background,
          fontFamily: 'Montserrat',
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CustomPageTransitionBuilder(),
            TargetPlatform.iOS: CustomPageTransitionBuilder(),
          }),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                TextStyle(color: appTheme.buttonTextColor),
              ),
            ),
          ),
          textTheme: TextTheme(
            button: TextStyle(
              color: appTheme.buttonTextColor,
            ),
            bodyText2: TextStyle(
              color: appTheme.buttonTextColor,
            ),
          ),
        ),
        home: const HomeScreen(),
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    );
  }
}
