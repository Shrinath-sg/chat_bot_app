import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/provider/my_provider.dart';
import 'package:task_app/screens/dashboard.dart';
import 'package:task_app/screens/login.dart';
import 'package:task_app/utils/ui_helper.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isInit = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _getUserProfile();
      // locator<DynamicLinkService>().initDynamicLinks();

      _isInit = false;
    }
    super.didChangeDependencies();
  }

  Future<void> _getUserProfile() async {
    //String? _token;
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.reload();
    // _token = prefs.getString("token");
    // print("TOKEN FROM SHARED PREFS-> $_token, ${_token.runtimeType}");
    // if (Platform.isAndroid || Platform.isIOS)
    try {
      Future.delayed(const Duration(seconds: 2), () async {
        final provider = Provider.of<MyProvider>(context, listen: false);
        await provider.getUser();
        inspect(provider.user);
        if (provider.user!.email != null) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              HomeScreen.routeName, (Route<dynamic> route) => false);
        } else {
          Navigator.of(context).pushReplacementNamed(
            LoginScreen.routeName,
          );
        }
      });
    } catch (e) {
      print('error in getUserProfile splash screen--> ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: UiHelper.height(context) * 0.15,
          child: Image.asset('assets/images/talkup.jpg'),
        ),
      ),
    );
  }
}
