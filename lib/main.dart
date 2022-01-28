import 'package:makeitdark/core/models/user_data.dart';
import 'package:makeitdark/core/routes/custom_route.dart';
import 'package:makeitdark/core/models/app_theme.dart';
import 'package:makeitdark/core/models/game.dart';
import 'package:makeitdark/core/models/game_field.dart';
import 'package:makeitdark/core/models/levels.dart';
import 'package:makeitdark/core/routes/routes.dart';
import 'package:makeitdark/features/home/screens/home_screen.dart';
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
          create: (context) => UserData(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => GameField(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider2<GameField, UserData, Game>(
          create: (context) => Game(Levels()),
          update: (context, gameField, userData, previousGame) =>
              previousGame!..initGame(gameField, userData),
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
