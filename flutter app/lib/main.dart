import 'package:flutter/material.dart';
import '../View/splash_screen.dart';
import 'View/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tbib',
      theme: ThemeData(
        primaryColor: Colors.white,
        hoverColor: Color.fromRGBO(217, 135, 17, 1),
        accentColor: Color.fromRGBO(135, 17, 217, 1),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
              Color.fromRGBO(217, 135, 17, 1),
            ),
            overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered))
                  return Color.fromRGBO(217, 135, 17, .2);
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed))
                  return Color.fromRGBO(217, 135, 17, .5);
                return Colors.red; // Defer to the widget's default.
              },
            ),
          ),
        ),
        selectedRowColor: Colors.red,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Color.fromRGBO(217, 135, 17, 1),
        ),
        primaryTextTheme: TextTheme(
          headline6: TextStyle(
            color: Color.fromRGBO(217, 135, 17, 1),
          ),
        ),
      ),
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
