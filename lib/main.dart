import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/provider/google_signin.dart';
import 'package:task_app/provider/my_provider.dart';
import 'package:task_app/screens/chat_screen.dart';
import 'package:task_app/screens/dashboard.dart';
import 'package:task_app/screens/login.dart';
import 'package:task_app/screens/signup.dart';
import 'package:task_app/screens/splash.dart';
import 'package:task_app/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => MyProvider()),
        ChangeNotifierProvider(create: (ctx) => GoogleSignInProvider()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: const MaterialColor(0xff6c3bed, AppColors.color),
            colorScheme:
                ColorScheme.fromSwatch(primarySwatch: AppColors.primeryColor)
                    .copyWith(secondary: AppColors.accentColor),
          ),
          home: const LoginScreen(),
          initialRoute: SplashScreen.routeName,
          routes: {
            LoginScreen.routeName: (context) => const LoginScreen(),
            SignupScreen.routeName: (context) => const SignupScreen(),
            HomeScreen.routeName: (context) => const HomeScreen(),
            ChatScreen.routeName: (context) => const ChatScreen(),
            SplashScreen.routeName: (context) => SplashScreen(),
          }),
    );
  }
}
