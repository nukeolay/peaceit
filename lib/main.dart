import 'package:backward/models/app_theme.dart';
import 'package:backward/models/game_field.dart';
import 'package:backward/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppTheme(),
        ),
        ChangeNotifierProvider(
          create: (context) => GameField(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'backward',
        theme: ThemeData(
          scaffoldBackgroundColor: context.read<AppTheme>().background,
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                TextStyle(color: context.read<AppTheme>().buttonTextColor),
              ),
            ),
          ),
          textTheme: TextTheme(
            button: TextStyle(
              color: context.read<AppTheme>().buttonTextColor,
            ),
            bodyText2: TextStyle(
              color: context.read<AppTheme>().buttonTextColor,
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
