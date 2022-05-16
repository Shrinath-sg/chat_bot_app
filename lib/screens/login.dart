import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:task_app/common_widgets/custom_button.dart';
import 'package:task_app/screens/dashboard.dart';
import 'package:task_app/screens/signup.dart';
import 'package:task_app/utils/colors.dart';
import 'package:task_app/utils/styles.dart';
import 'package:task_app/utils/ui_helper.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: UiHelper.height(context) * 0.05,
              ),
              SizedBox(
                height: UiHelper.height(context) * 0.15,
                child: Image.asset('assets/images/talkup.jpg'),
              ),
              Text(
                'Welcome Back!',
                style: Styles.headingStyle1(),
              ),
              SizedBox(
                height: UiHelper.height(context) * 0.08,
              ),
              TextFormField(
                cursorColor: Colors.black,
                decoration: Styles.textFormFieldStyle(
                  hintText: 'Username or e-mail',
                  labelText: 'Email',
                ),
              ),
              SizedBox(
                height: UiHelper.height(context) * 0.03,
              ),
              TextField(
                cursorColor: Colors.black,
                decoration: Styles.textFormFieldStyle(
                    labelText: 'Password',
                    hintText: "Password",
                    prefixIconData: Iconsax.key),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: UiHelper.height(context) * 0.05,
              ),
              CustomButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, HomeScreen.routeName);
                },
                text: 'Login',
              ),
              SizedBox(
                height: UiHelper.height(context) * 0.02,
              ),
              Text(
                'OR',
                style: Styles.headingStyle4(isBold: true),
              ),
              SizedBox(
                height: UiHelper.height(context) * 0.02,
              ),
              InkWell(
                onTap: () {},
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFF397AF3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SizedBox(
                          height: UiHelper.height(context) * 0.03,
                          child: Image.asset('assets/images/google_icon.jpeg'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Sign in with Google',
                          style: Styles.headingStyle4(
                              isBold: true, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: UiHelper.height(context) * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: Styles.headingStyle4(),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignupScreen.routeName);
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                          color: AppColors.purple,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
