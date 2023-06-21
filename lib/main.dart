
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:my_news_app_/helpers/auth_helper_data.dart';
import 'package:my_news_app_/helpers/theme_color_data.dart';
import 'package:my_news_app_/screens/article_detail_page_screen.dart';
import 'package:my_news_app_/screens/dosya_islemleri.dart';
import 'package:my_news_app_/screens/dosya_islemleri2.dart';
import 'package:my_news_app_/screens/favorite_article_page_screen.dart';
import 'package:my_news_app_/screens/grafik_page.dart';
import 'package:my_news_app_/screens/home_page_screen.dart';
import 'package:my_news_app_/screens/profil_page.dart';
import 'package:my_news_app_/screens/settings_page_screen.dart';
import 'package:my_news_app_/screens/signin_page_screen.dart';
import 'package:my_news_app_/screens/singup_page_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeColorData().createSharedPrefObj();
  await Locales.init(['en', 'us', 'tr']);
  await Firebase.initializeApp();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeColorData>(
          create: (BuildContext context) => ThemeColorData(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;

  final _routes = {
    "/homePageScreen": (context) => const HomePageScreen(),
    "/settingsPageScreen": (context) => const SettingsPageScreen(),
    "/signinPageScreen": (context) => const SignInPageScreen(),
    "/signupPageScreen": (context) => const SignUpPageScreen(),
    "/articleDetailPageScreen": (context) => const ArticleDetailScreenPage(),
    "/favoriteArticlePageScreen": (context) =>
        const FavoriteArticlePageScreen(),
    "/Profil": (context) => const Profil(),
    '/Grafik':(context)=>  ChartExample(),
    '/Dosya':(context)=>  FileOperationsScreen (),
    '/Dosya2':(context)=>  FileDownloadView (),


  };
  
  

  

  getUserInfo() async {
    userIsLoggedIn = await HelperFunctions.getUserLoggedInSharedPreference();
    setState(() {});
  }

  @override
  void initState() {
    SharedPreferences.getInstance();
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeColorData>(context, listen: false).loadThemeSharedPref();

    return LocaleBuilder(
      builder: (locale) => MaterialApp(
        localizationsDelegates: Locales.delegates,
        supportedLocales: Locales.supportedLocales,
        locale: locale,
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeColorData>(context).getThemeColor,
        routes: _routes,
        initialRoute: userIsLoggedIn ? "/homePageScreen" : "/signinPageScreen",
      ),
    );
  }
}