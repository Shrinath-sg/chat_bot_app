import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:task_app/common_widgets/custom_button.dart';
import 'package:task_app/provider/my_provider.dart';
import 'package:task_app/screens/dashboard.dart';
import 'package:task_app/screens/signup.dart';
import 'package:task_app/utils/colors.dart';
import 'package:task_app/utils/styles.dart';
import 'package:task_app/utils/ui_helper.dart';
import 'package:task_app/utils/constants.dart' as constants;

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtl = TextEditingController();
  // @override
  // void initState() {
  //   Future.delayed(Duration.zero, (() => getInitail()));
  //   super.initState();
  // }

  // getInitail() async {
  //   final provider = Provider.of<MyProvider>(context, listen: false);
  //   await provider.getUser();
  //   // var _user = provider.user;
  //   // if (_user != null) {}
  // }

  final _passwordCtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context, listen: false);
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () async {
      //   await MySharedPreferences.instance.removeAll();
      //   await MySharedPreferences.instance.reload();
      // }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
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
                  controller: _emailCtl,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: Styles.textFormFieldStyle(
                    hintText: 'Username or e-mail',
                    labelText: 'Email',
                  ),
                  validator: (val) {
                    if (!constants.emailRegExp.hasMatch(val!)) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: UiHelper.height(context) * 0.03,
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  controller: _passwordCtl,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: Styles.textFormFieldStyle(
                      labelText: 'Password',
                      hintText: "Password",
                      prefixIconData: Iconsax.key),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter passsword";
                    }
                    return null;
                  },
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
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (!_formKey.currentState!.validate()) {
                      Fluttertoast.showToast(
                          msg: 'Please fill all mandatory fields');
                      return;
                    }
                    // inspect(provider.user);
                    if (provider.user!.email == null) {
                      UiHelper.openLoadingDialog(context, "Please wait..");
                      await Future.delayed(const Duration(seconds: 2));
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg: 'No user found! please register');
                      return;
                    }

                    if (provider.user!.email == _emailCtl.text.trim() &&
                        provider.user!.password == _passwordCtl.text.trim()) {
                      UiHelper.openLoadingDialog(context, "Logging in..");
                      await Future.delayed(const Duration(seconds: 2));
                      // Navigator.pop(context)
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        HomeScreen.routeName,
                        (route) => false,
                      );
                    } else {
                      Fluttertoast.showToast(
                          msg: 'No user found! please register');
                    }
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
                  onTap: () async {
                    // final gProvider = Provider.of<GoogleSignInProvider>(context,
                    //     listen: false);
                    // try {
                    //   final result = await gProvider.googleLoginDailog();
                    //   if (result == "pass") {
                    //     // try {
                    //     if (!mounted) return;
                    //     UiHelper.openLoadingDialog(context, 'Authenticating..');
                    //     await gProvider.googleLogin();
                    //     final userData = gProvider.userCredential;
                    //     if (userData != null) {
                    //       provider.signUp(UserModel(
                    //           email: userData.user!.email,
                    //           name: userData.user!.displayName,
                    //           phone: userData.user!.phoneNumber));
                    //       Navigator.pushNamedAndRemoveUntil(
                    //         context,
                    //         HomeScreen.routeName,
                    //         (route) => false,
                    //       );
                    //     }
                    //   }
                    // } catch (err) {
                    //   Fluttertoast.showToast(msg: 'something went wrong!!');
                    // }
                  },
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
                            child:
                                Image.asset('assets/images/google_icon.jpeg'),
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
      ),
    );
  }
}
