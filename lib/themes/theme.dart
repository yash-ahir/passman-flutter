import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicThemes {
  static NeumorphicThemeData get lightTheme {
    return NeumorphicThemeData(
      baseColor: Color(0xFFd8d8d8),
      accentColor: Colors.cyan,
      lightSource: LightSource.topLeft,
      defaultTextColor: Colors.black,
      depth: 5,
      shadowDarkColor: Color(0xFF565656),
      shadowDarkColorEmboss: Color(0xFF565656),
      shadowLightColor: Color(0xFFffffff),
      shadowLightColorEmboss: Color(0xFFffffff),
      textTheme: NeumorphicThemeData().textTheme.copyWith(
            bodyText1: TextStyle(
              fontFamily: "FiraSansCondensed",
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black,
            ),
            bodyText2: TextStyle(
              fontFamily: "Raleway",
              fontSize: 22,
              color: Colors.black,
            ),
            headline6: TextStyle(
              fontFamily: "Raleway",
              fontSize: 20,
              color: Colors.black,
            ),
            caption: TextStyle(
              fontFamily: "FiraSansCondensed",
              fontSize: 16,
            ),
          ),
      appBarTheme: NeumorphicAppBarThemeData(
        iconTheme: IconThemeData(color: Colors.cyan),
        buttonStyle: NeumorphicStyle(
          depth: 5,
          shadowDarkColor: Color(0xFF565656),
          shadowLightColor: Color(0xFFffffff),
          lightSource: LightSource.topLeft,
        ),
        textStyle: TextStyle(color: Colors.black),
      ),
    );
  }

  static NeumorphicThemeData get darkTheme {
    return NeumorphicThemeData.dark(
      baseColor: Color(0xFF181818),
      accentColor: Colors.blue,
      lightSource: LightSource.bottomRight,
      defaultTextColor: Colors.white,
      depth: 5,
      shadowDarkColor: Color(0xFF040404),
      shadowDarkColorEmboss: Color(0xFF040404),
      shadowLightColor: Color(0xFF282828),
      shadowLightColorEmboss: Color(0xFF282828),
      textTheme: NeumorphicThemeData.dark().textTheme.copyWith(
            bodyText1: TextStyle(
              fontFamily: "FiraSansCondensed",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            bodyText2: TextStyle(
              fontFamily: "Raleway",
              fontSize: 22,
              color: Colors.white,
            ),
            headline6: TextStyle(
              fontFamily: "Raleway",
              fontSize: 20,
              color: Colors.white,
            ),
            caption: TextStyle(
              fontFamily: "FiraSansCondensed",
              fontSize: 16,
            ),
          ),
      appBarTheme: NeumorphicAppBarThemeData(
        iconTheme: IconThemeData(color: Colors.blue),
        buttonStyle: NeumorphicStyle(
          depth: 5,
          lightSource: LightSource.bottomRight,
        ),
        textStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
