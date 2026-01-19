import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/login_screen.dart';
import 'screens/vehicle_selection_screen.dart';
import 'screens/launcher_screen.dart';
// import 'providers/intro_provider.dart';
// import 'providers/language_provider.dart'; 
// import 'providers/theme_provider.dart';
// import 'theme/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final languageProvider = LanguageProvider();
  // final themeProvider = ThemeProvider();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: const [
        // ChangeNotifierProvider(create: (ctx) => IntroProvider()),
        // ChangeNotifierProvider.value(value: languageProvider),
        // ChangeNotifierProvider.value(value: themeProvider),
        // ],
      // child: MaterialApp(
      return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vehicle Launcher',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // textTheme: const TextTheme(
          //   bodyLarge: TextStyle(color: Colors.white),
          //   bodyMedium: TextStyle(color: Colors.white),
          //   displayLarge: TextStyle(color: Colors.white),
          //   titleLarge: TextStyle(color: Colors.white),
          // ),
          elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.pink,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        
        

        ),
        home: const HomeSelector(),
        routes: {
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          VehicleSelectionScreen.routeName: (ctx) => const VehicleSelectionScreen(),
          LauncherScreen.routeName: (ctx) => const LauncherScreen(),
        },
      // ),
    );
  }
}

class HomeSelector extends StatefulWidget {
  const HomeSelector({super.key});

  @override
  State<HomeSelector> createState() => _HomeSelectorState();
}

class _HomeSelectorState extends State<HomeSelector> {
  // bool _isLoading = true;
  // bool _introCompleted = false;

  @override
  void initState() {
    super.initState();
    // _checkStatus();
  }

  // Future<void> _checkStatus() async {
  //   // Itt csekkolod az Intro-t vagy akár a Login státuszt
  //   final completed = await IntroProvider.getIntroCompleted();
  //   setState(() {
  //     _introCompleted = completed;
  //     _isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // if (_isLoading) {
    //   return const Scaffold(body: Center(child: CircularProgressIndicator()));
    // }

    // return _introCompleted 
    //     ? const LoginScreen() 
    //     : const  PlaceholderIntroScreen(); 

    return const LoginScreen();
  }
}

// Csak hogy ne dobjon hibát, amíg nincs meg az igazi intro screen
// class PlaceholderIntroScreen extends StatelessWidget {
//   const PlaceholderIntroScreen({super.key});
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     body: Center(
//       child: TextButton(
//         onPressed: () => Navigator.of(context).pushReplacementNamed(LoginScreen.routeName),
//         child: const Text('Intro Screen (Tap to skip to Login)'),
//       ),
//     ),
//   );
// }