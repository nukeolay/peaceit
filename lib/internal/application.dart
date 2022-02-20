import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:darkit/core/theme/app_theme.dart';
import 'package:darkit/core/routes/custom_route.dart';
import 'package:darkit/core/routes/routes.dart';
import 'package:darkit/presentation/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppTheme(),
        ),
      ],
      child: const DarkItApp(),
    );
  }
}

class DarkItApp extends StatelessWidget {
  const DarkItApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
      builder: (context, appTheme, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '[dark it]',
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
