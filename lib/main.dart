import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/firebase_options.dart';
import 'package:mental_health_app/model_data_user.dart';
import 'package:provider/provider.dart';
import 'splashscreen.dart';
import 'routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Error handling untuk Firebase initialization
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Log the error or show an alert dialog
    print("Firebase initialization failed: $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserModel()), // Initialize UserModel
        // Tambahkan provider lain jika diperlukan
        // ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mental Health App',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Menggunakan const untuk optimasi
      ),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
