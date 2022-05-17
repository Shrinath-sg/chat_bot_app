import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:task_app/common_widgets/custom_button.dart';
import 'package:task_app/models/user_model.dart';
import 'package:task_app/provider/my_provider.dart';
import 'package:task_app/screens/login.dart';
import 'package:task_app/utils/colors.dart';
import 'package:task_app/utils/styles.dart';
import 'package:task_app/utils/ui_helper.dart';
import 'package:task_app/utils/constants.dart' as constants;

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailCtl = TextEditingController();

  final _passwordCtl = TextEditingController();

  final _nameCtl = TextEditingController();

  final _phoneCtl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return Scaffold(
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
                  'Lets Get Started!',
                  style: Styles.headingStyle1(),
                ),
                SizedBox(
                  height: UiHelper.height(context) * 0.08,
                ),
                TextFormField(
                  controller: _nameCtl,
                  cursorColor: Colors.black,
                  decoration: Styles.textFormFieldStyle(
                    hintText: 'Name*',
                    labelText: 'Name*',
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter something";
                    } else if (val.length < 3) {
                      return 'Enter valid name';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(
                  height: UiHelper.height(context) * 0.03,
                ),
                TextFormField(
                  controller: _phoneCtl,
                  cursorColor: Colors.black,
                  decoration: Styles.textFormFieldStyle(
                      hintText: 'Phone*',
                      labelText: 'Phone*',
                      prefixIconData: Iconsax.mobile),
                  validator: (value) {
                    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                    RegExp regExp = RegExp(patttern);
                    if (value!.isEmpty) {
                      return 'Please enter mobile number';
                    } else if (!regExp.hasMatch(value)) {
                      return 'Please enter valid mobile number';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(
                  height: UiHelper.height(context) * 0.03,
                ),
                TextFormField(
                  controller: _emailCtl,
                  cursorColor: Colors.black,
                  decoration: Styles.textFormFieldStyle(
                    hintText: 'Username or e-mail*',
                    labelText: 'Email*',
                  ),
                  validator: (val) {
                    // String p =
                    //     ;

                    // RegExp regExp = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

                    if (!constants.emailRegExp.hasMatch(val!)) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(
                  height: UiHelper.height(context) * 0.03,
                ),
                TextFormField(
                  controller: _passwordCtl,
                  cursorColor: Colors.black,
                  onChanged: (value) {
                    provider.checkPassword(value);
                  },
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Please enter you password';
                  //   } else if (value.length < 6) {
                  //     return 'Your password is too short';
                  //   }else if(!constants.regex.hasMatch(value)){
                  //     return 'password is weak';
                  //   }
                  //   return null;
                  // },
                  decoration: Styles.textFormFieldStyle(
                      hintText: 'Password*',
                      labelText: 'Password*',
                      prefixIconData: Iconsax.key),
                ),
                SizedBox(
                  height: UiHelper.height(context) * 0.03,
                ),
                if (_passwordCtl.text.isNotEmpty)
                  LinearProgressIndicator(
                    value: provider.strength,
                    backgroundColor: Colors.grey[300],
                    color: provider.strength! <= 1 / 4
                        ? Colors.red
                        : provider.strength! == 2 / 4
                            ? Colors.yellow
                            : provider.strength! == 3 / 4
                                ? Colors.blue
                                : Colors.green,
                    minHeight: 15,
                  ),
                if (_passwordCtl.text.isNotEmpty)
                  SizedBox(
                    height: UiHelper.height(context) * 0.03,
                  ),
                if (_passwordCtl.text.isNotEmpty)
                  // The message about the strength of the entered password
                  Text(
                    provider.displayText ?? '',
                    style: Styles.headingStyle4(isBold: true),
                  ),
                SizedBox(
                  height: UiHelper.height(context) * 0.05,
                ),
                CustomButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (!_formKey.currentState!.validate()) {
                      Fluttertoast.showToast(
                          msg: 'please fill all mandatory fields');
                      return;
                    }
                    if (provider.strength! > 1 / 2) {
                      try {
                        var user = UserModel(
                            email: _emailCtl.text.trim(),
                            password: _passwordCtl.text.trim(),
                            name: _nameCtl.text,
                            phone: _phoneCtl.text.trim());
                        UiHelper.openLoadingDialog(context, "Please wait...");
                        await provider.signUp(user);
                        Navigator.pop(context);
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginScreen.routeName, (route) => false);
                      } catch (err) {
                        Fluttertoast.showToast(msg: 'something went wrong!!');
                      }
                    } else {
                      Fluttertoast.showToast(msg: 'Password is weak');
                    }
                  },
                  text: 'Sign Up',
                ),
                SizedBox(
                  height: UiHelper.height(context) * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: Styles.headingStyle4(),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(
                            context, LoginScreen.routeName);
                      },
                      child: const Text(
                        'Login',
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
