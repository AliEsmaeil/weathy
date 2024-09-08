import 'package:flutter/material.dart';

class AppTheme{

  static final  lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 40,
        overflow: TextOverflow.clip,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        color: Colors.black,
        fontSize: 20,
        overflow: TextOverflow.clip,
        fontWeight: FontWeight.normal,
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.normal,
      ),

      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),
      cardTheme: CardTheme(
      color: Colors.white,
      elevation: .2,
      margin: EdgeInsets.all(8),
      shadowColor: Colors.black,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    iconTheme: IconThemeData(
      size: 20,
    ),
    // Search bar and search view route visual property customization
    searchBarTheme: SearchBarThemeData(
      surfaceTintColor: MaterialStatePropertyAll(Colors.grey.shade100,),
      shadowColor: MaterialStatePropertyAll(Colors.grey.shade400),
      elevation: MaterialStatePropertyAll(.2),
      backgroundColor: MaterialStatePropertyAll(Colors.grey.shade100,),
      hintStyle: MaterialStatePropertyAll(TextStyle(fontSize: 16, color: Colors.grey.shade500, fontWeight: FontWeight.w300)),
      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 8)),
      textCapitalization: TextCapitalization.words,
    ),
    searchViewTheme: SearchViewThemeData(
      backgroundColor: Colors.white,
      elevation: .2,
      surfaceTintColor: Colors.white,
      dividerColor: Colors.grey.shade100,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 1,
      iconSize: 20,
      foregroundColor: Colors.white,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.black),
        backgroundColor: MaterialStatePropertyAll(Colors.white),
        surfaceTintColor: MaterialStatePropertyAll(Colors.white),
        alignment: Alignment.center,
        iconColor: MaterialStatePropertyAll(Colors.orange,),
        side: MaterialStatePropertyAll(BorderSide(color: Colors.grey.shade100, width: 1),)
      )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.blueGrey.shade200,
      elevation: .2,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedItemColor: Colors.grey.shade500,
      selectedItemColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: Colors.white,
      scrolledUnderElevation: 0,

    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.white),
        foregroundColor: MaterialStatePropertyAll(Colors.black),
        elevation: MaterialStatePropertyAll(0),
        side: MaterialStatePropertyAll(BorderSide(color: Colors.grey.shade200,)),
        overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
      )
    ),
    tabBarTheme: TabBarTheme(
      overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
      indicator: UnderlineTabIndicator(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: Colors.black, width: 2.5),
      ),
      labelColor:  Colors.black,
      unselectedLabelColor: Colors.grey,

    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
        foregroundColor: MaterialStatePropertyAll(Colors.black),
        side: MaterialStatePropertyAll(BorderSide(width: .5 , color: Colors.grey.shade300)),
        backgroundColor: MaterialStatePropertyAll(Colors.white),
        surfaceTintColor: MaterialStatePropertyAll(Colors.white),
        padding: MaterialStatePropertyAll(EdgeInsets.all(8)),
        minimumSize: MaterialStatePropertyAll(Size(double.infinity, 35)),
      )
    ),
    snackBarTheme: SnackBarThemeData(
      elevation: 1,
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12)) ,),
      dismissDirection: DismissDirection.horizontal,
      showCloseIcon: false,
      width: double.infinity,
      behavior: SnackBarBehavior.floating,
    ),

  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.grey.shade200,
        fontSize: 40,
        overflow: TextOverflow.clip,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        color: Colors.grey.shade200,
        fontSize: 20,
        overflow: TextOverflow.clip,
        fontWeight: FontWeight.normal,
      ),
      titleMedium: TextStyle(
        color: Colors.grey.shade200,
        fontSize: 30,
        fontWeight: FontWeight.normal,
      ),

      bodyMedium: TextStyle(
        color: Colors.grey.shade200,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        color: Colors.grey.shade200,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      bodyLarge: TextStyle(
        color: Colors.grey.shade200,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.black,
      elevation: .2,
      margin: EdgeInsets.all(8),
      shadowColor: Colors.black,
      surfaceTintColor: Colors.grey.shade200,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    iconTheme: IconThemeData(
      size: 20,
      color: Colors.grey.shade200,
    ),
    // Search bar and search view route visual property customization
    searchBarTheme: SearchBarThemeData(
      surfaceTintColor: MaterialStatePropertyAll(Colors.grey.shade800,),
      shadowColor: MaterialStatePropertyAll(Colors.grey.shade300),
      elevation: MaterialStatePropertyAll(.2),
      backgroundColor: MaterialStatePropertyAll(Colors.grey.shade800,),
      hintStyle: MaterialStatePropertyAll(TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w300)),
      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 8)),
      textCapitalization: TextCapitalization.words,
    ),
    searchViewTheme: SearchViewThemeData(
      backgroundColor: Colors.grey.shade800,
      elevation: .2,
      surfaceTintColor: Colors.grey.shade800,
      dividerColor: Colors.grey.shade700,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 1,
      iconSize: 20,
      foregroundColor: Colors.grey.shade200,
    ),
    filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.grey.shade200,),
            backgroundColor: MaterialStatePropertyAll(Colors.black),
            surfaceTintColor: MaterialStatePropertyAll(Colors.grey.shade200),
            alignment: Alignment.center,
            iconColor: MaterialStatePropertyAll(Colors.orange,),
            side: MaterialStatePropertyAll(BorderSide(color: Colors.grey, width: 1),)
        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      elevation: .2,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedItemColor: Colors.grey.shade500,
      selectedItemColor: Colors.grey.shade200,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: Colors.black,
      scrolledUnderElevation: 0,

    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.grey.shade800),
          foregroundColor: MaterialStatePropertyAll(Colors.grey.shade200),
          elevation: MaterialStatePropertyAll(0),
          side: MaterialStatePropertyAll(BorderSide(color: Colors.grey.shade600,)),
          overlayColor: MaterialStatePropertyAll(Colors.grey),
        )
    ),
    tabBarTheme: TabBarTheme(
      overlayColor: MaterialStatePropertyAll(Colors.grey.shade600),
      indicator: UnderlineTabIndicator(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: Colors.grey.shade200, width: 2.5),
      ),
      labelColor:  Colors.grey.shade200,
      unselectedLabelColor: Colors.grey.shade600,

    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: MaterialStatePropertyAll(Colors.grey.shade100),
          foregroundColor: MaterialStatePropertyAll(Colors.grey.shade200),
          side: MaterialStatePropertyAll(BorderSide(width: .5 , color: Colors.grey.shade300)),
          backgroundColor: MaterialStatePropertyAll(Colors.black),
          surfaceTintColor: MaterialStatePropertyAll(Colors.black),
          padding: MaterialStatePropertyAll(EdgeInsets.all(8)),
          minimumSize: MaterialStatePropertyAll(Size(double.infinity, 35)),
        )
    ),
    snackBarTheme: SnackBarThemeData(
      elevation: 1,
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12)) ,),
      dismissDirection: DismissDirection.horizontal,
      showCloseIcon: false,
      width: double.infinity,
      behavior: SnackBarBehavior.floating,
    ),

  );
}