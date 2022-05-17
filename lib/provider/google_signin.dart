import 'dart:developer' as dev;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

// import 'package:googleapis/drive/v2.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  UserCredential? _userCredential;
  GoogleSignInAuthentication? _googleSignInAuthentication;
  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;
  UserCredential? get userCredential => _userCredential;

  Future<String?> googleLoginDailog() async {
    String? result = 'Failed';
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return result;
      //_user = googleUser;
      _googleSignInAuthentication = await googleUser.authentication;
      print(_googleSignInAuthentication!.idToken);
      if (_googleSignInAuthentication != null) {
        print('***');
        return result = 'pass';
      }
      notifyListeners();
      return result;
    } catch (e) {
      print("google signinDailog error -->> ${e.toString()}");
    }
    return null;
  }

  Future<String?> googleLogin() async {
    String? result = 'Failed';
    try {
      final credential = GoogleAuthProvider.credential(
        accessToken: _googleSignInAuthentication!.accessToken,
        idToken: _googleSignInAuthentication!.idToken,
      );
      final userData = await FirebaseAuth.instance
          .signInWithCredential(credential)
          .catchError((e) {
        dev.log(e.toString());
      });
      // dev.log('user data is ->> ${userData.credential!.token}');
      _userCredential = userData;
      final _token = await userData.user!.getIdToken();
      if (_userCredential != null) {
        dev.log('inside here');
        return result = 'pass';
      }
      notifyListeners();
      return result;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
      throw Exception(
          e.message); // Or extend this with a custom exception class
    } catch (e) {
      print("google signin error -->> ${e.toString()}");
    }
    return null;
  }

  Future logout() async {
    try {
      // throw Error();
      final String _uid = FirebaseAuth.instance.currentUser!.uid;
      if (_uid.isNotEmpty) {
        await googleSignIn.disconnect();
        await FirebaseAuth.instance.signOut();
        // print('loggedout!!');
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
      //     print('''
      //   caught firebase auth exception\n
      //   ${e.code}\n
      //   ${e.message}
      // ''');

      //     var message = 'Oops!'; // Default message
      //     switch (e.code) {
      //       case 'ERROR_WRONG_PASSWORD':
      //         message = 'The password you entered is totally wrong!';
      //         break;
      //       // More custom messages ...
      //     }
      throw Exception(
          e.message); // Or extend this with a custom exception class
    } catch (e) {
      print('error while logout from firebase --> ${e.toString()}');
    }
  }
}
