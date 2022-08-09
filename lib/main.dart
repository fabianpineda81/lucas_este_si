import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lucas/screens/Splash.dart';

import 'package:lucas/themes/ThemeNotifier.dart';
import 'package:lucas/themes/themes.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/property_change_notifier/property_change_provider.dart';
import 'models/LucasState.dart';
import 'module_backup_reestore/helper_file.dart';

//void main() => runApp(MyApp());
// void main() => runApp(
//       ChangeNotifierProvider<ThemeNotifier>(
//         builder: (_) => ThemeNotifier(lightTheme),
//         child: MyApp(),
//       ),
//     );
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HelPerFile.crearDirectorioFinal();
  SharedPreferences.getInstance().then((prefs) {
    var darkModeOn = prefs.getBool('darkMode') ?? false;
    var currentColor = prefs.getString('currentColor') ?? 'blue';
    //L.loadWords();
    //ImageCard.loadImages();

    if (darkModeOn) {
      if (currentColor == 'amber') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(darkAmberTheme),
            //builder: (_) => ThemeNotifier(darkAmberTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'blue') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(darkBlueTheme),
            //builder: (_) => ThemeNotifier(darkBlueTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'cyan') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(darkCyanTheme),
            //builder: (_) => ThemeNotifier(darkCyanTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'deepOrange') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(darkDeepOrangeTheme),
            //builder: (_) => ThemeNotifier(darkDeepOrangeTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'deepPurple') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(darkDeepPurpleTheme),
            //builder: (_) => ThemeNotifier(darkDeepPurpleTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'green') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(darkGreenTheme),
            //builder: (_) => ThemeNotifier(darkGreenTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'indigo') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(darkIndigoTheme),
            //builder: (_) => ThemeNotifier(darkIndigoTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'lightBlue') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(darkLightBlueTheme),
            //builder: (_) => ThemeNotifier(darkLightBlueTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'lightGreen') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(darkLightGreenTheme),
            //builder: (_) => ThemeNotifier(darkLightGreenTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'lime') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(darkLimeTheme),
            //builder: (_) => ThemeNotifier(darkLimeTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'orange') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(darkOrangeTheme),
            //builder: (_) => ThemeNotifier(darkOrangeTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'pink') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(darkPinkTheme),
            //builder: (_) => ThemeNotifier(darkPinkTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'purple') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(darkPurpleTheme),
            //builder: (_) => ThemeNotifier(darkPurpleTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'red') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(darkRedTheme),
            //builder: (_) => ThemeNotifier(darkRedTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'teal') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(darkTealTheme),
            //builder: (_) => ThemeNotifier(darkTealTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'yellow') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(darkYellowTheme),
            //builder: (_) => ThemeNotifier(darkYellowTheme),
            child: MyApp(),
          ),
        );
      }
    }

    if (!darkModeOn) {
      if (currentColor == 'amber') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(lightAmberTheme),
            //builder: (_) => ThemeNotifier(lightAmberTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'blue') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(lightBlueTheme),
            //builder: (_) => ThemeNotifier(lightBlueTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'cyan') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(lightCyanTheme),
            //builder: (_) => ThemeNotifier(lightCyanTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'deepOrange') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(lightDeepOrangeTheme),
            //builder: (_) => ThemeNotifier(lightDeepOrangeTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'deepPurple') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(lightDeepPurpleTheme),
            //builder: (_) => ThemeNotifier(lightDeepPurpleTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'green') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(lightGreenTheme),
            //builder: (_) => ThemeNotifier(lightGreenTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'indigo') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(lightIndigoTheme),
            // builder: (_) => ThemeNotifier(lightIndigoTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'lightBlue') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(lightLightBlueTheme),
            //builder: (_) => ThemeNotifier(lightLightBlueTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'lightGreen') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(lightLightGreenTheme),
            //builder: (_) => ThemeNotifier(lightLightGreenTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'lime') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(lightLimeTheme),
            //builder: (_) => ThemeNotifier(lightLimeTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'orange') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(lightOrangeTheme),
            //builder: (_) => ThemeNotifier(lightOrangeTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'pink') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(lightPinkTheme),
            //builder: (_) => ThemeNotifier(lightPinkTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'purple') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(lightPurpleTheme),
            //builder: (_) => ThemeNotifier(lightPurpleTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'red') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(lightRedTheme),
            //builder: (_) => ThemeNotifier(lightRedTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'teal') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(lightTealTheme),
            //builder: (_) => ThemeNotifier(lightTealTheme),
            child: MyApp(),
          ),
        );
      }
      if (currentColor == 'yellow') {
        runApp(
          ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier(lightYellowTheme),
            //builder: (_) => ThemeNotifier(lightYellowTheme),
            child: MyApp(),
          ),
        );
      }
    }
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // precacheImage(
    //     FileImage(File(
    //         '/data/user/0/com.lucaseducation.apps.lucas/app_flutter/lucas/20191209_175837.jpg')),
    //     context);
    // precacheImage(
    //     FileImage(File(
    //         '/data/user/0/com.lucaseducation.apps.lucas/app_flutter/lucas/20191209_175847.jpg')),
    //     context);
    // precacheImage(
    //     FileImage(File(
    //         '/data/user/0/com.lucaseducation.apps.lucas/app_flutter/lucas/20191207_205419.jpg')),
    //     context);

    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return PropertyChangeProvider(
      value: LucasState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lucas the Lion',
        // Set theme according to selected color ("currentColor") and darkmode ("darkMode")
        theme: themeNotifier.getTheme(),
        home:
            // PropertyChangeProvider(
            //   value: LucasState(),
            //   child:
            //RecorderDemo(),
            //SwipeLeftRightDismissible(),
            //VideoPlayerScreen(),
            //PushMessagingExample(),
            //TestingSockets(),
            Splash(),
        //ViewYouTubeVideo(),
        //),
        locale: Locale('en'),
        //),
      ),
    );
  }
}
