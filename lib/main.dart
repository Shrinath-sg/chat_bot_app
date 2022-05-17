import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/provider/my_provider.dart';
import 'package:task_app/screens/chat_screen.dart';
import 'package:task_app/screens/dashboard.dart';
import 'package:task_app/screens/login.dart';
import 'package:task_app/screens/signup.dart';
import 'package:task_app/utils/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => MyProvider()),
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
          initialRoute: LoginScreen.routeName,
          routes: {
            LoginScreen.routeName: (context) => const LoginScreen(),
            SignupScreen.routeName: (context) => const SignupScreen(),
            HomeScreen.routeName: (context) => const HomeScreen(),
            ChatScreen.routeName: (context) => const ChatScreen(),
          }),
    );
  }
}
