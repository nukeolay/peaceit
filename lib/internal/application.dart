import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:peaceit/core/theme/app_theme.dart';
import 'package:peaceit/core/routes/custom_route.dart';
import 'package:peaceit/core/routes/routes.dart';
import 'package:peaceit/presentation/home/home_screen.dart';

class PeaceItApp extends StatelessWidget {
  const PeaceItApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppTheme(),
        ),
      ],
      child: Consumer<AppTheme>(
        builder: (context, appTheme, _) => MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: '[peace it]',
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
      ),
    );
  }
}
