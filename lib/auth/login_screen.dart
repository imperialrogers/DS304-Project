// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import 'auth_form.dart';

// class AuthScreen extends StatefulWidget {
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   final _auth = FirebaseAuth.instance;
//   var _isLoading = false;

//   void _submitAuthForm(
//     String email,
//     String password,
//     String username,
//     File image,
//     bool isLogin,
//     BuildContext ctx,
//   ) async {
//     final authResult;
//     try {
//       setState(() {
//         _isLoading = true;
//       });
//       if (isLogin) {
//         authResult = await _auth.signInWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//       } else {
//         authResult = await _auth.createUserWithEmailAndPassword(
//           email: email,
//           password: password,
//         );

//         final user = await FirebaseAuth.instance.currentUser;
//         user!.updateDisplayName(username);

//         // Upload Image
//         final ref = FirebaseStorage.instance
//             .ref()
//             .child('user_image')
//             .child(authResult.user.uid + '.jpg');

//         await ref
//             .putFile(
//           image,
//         )
//             .whenComplete(() {
//           print('COMPLETED UPLOADING IMAGE');
//         });

//         //Get the URL
//         final url = await ref.getDownloadURL();

//         user.updatePhotoURL(url);
//         //Save in User Database
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(authResult.user.uid)
//             .set({
//           'username': username,
//           'email': email,
//           'image_url': url,
//         });
//       }
//       //Exception Handling
//     } on FirebaseAuthException catch (e) {
//       var message = '';
//       if (e.code == 'user-not-found') {
//         message = ('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         message = ('Wrong password provided for that user.');
//       } else {
//         message = e.toString();
//       }
//       ScaffoldMessenger.of(ctx).showSnackBar(
//         SnackBar(
//           content: Text(message),
//         ),
//       );
//       setState(() {
//         _isLoading = false;
//       });
//     } catch (err) {
//       print(err);
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   // UI
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AuthForm(
//         _submitAuthForm,
//         _isLoading,
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'dart:io';

import 'package:ds304/dialogs.dart';
import 'package:ds304/helpers/apis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../pages/homescreen.dart';

//login screen -- implements google sign in or sign up feature for app
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();

    //for auto triggering animation
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => _isAnimate = true);
    });
  }

  // handles google login button click
  _handleGoogleBtnClick() {
    //for showing progress bar
    Dialogs.showProgressBar(context);

    _signInWithGoogle().then((user) async {
      //for hiding progress bar
      Navigator.pop(context);

      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

        if ((await APIs.userExists())) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        } else {
          await APIs.createUser().then((value) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          });
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      print(
          "--------------------------------------------------------------------------------------------");
      Dialogs.showSnackbar(context, 'Something Went Wrong (Check Internet!)');
      return null;
    }
  }

  //sign out function
  // _signOut() async {
  //   await FirebaseAuth.instance.signOut();
  //   await GoogleSignIn().signOut();
  // }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      //app bar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Welcome to We Chat'),
      ),

      //body
      body: Stack(children: [
        //app logo
        AnimatedPositioned(
            top: mq.height * .15,
            right: _isAnimate ? mq.width * .25 : -mq.width * .5,
            width: mq.width * .5,
            duration: const Duration(seconds: 1),
            child: Image.asset('images/icon.png')),

        //google login button
        Positioned(
            bottom: mq.height * .15,
            left: mq.width * .05,
            width: mq.width * .9,
            height: mq.height * .06,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 223, 255, 187),
                    shape: const StadiumBorder(),
                    elevation: 1),
                onPressed: () {
                  _handleGoogleBtnClick();
                },

                //google icon
                icon: Image.network(
                    'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-suite-everything-you-need-know-about-google-newest-0.png',
                    height: mq.height * .03),

                //login with google label
                label: RichText(
                  text: const TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: [
                        TextSpan(text: 'Login with '),
                        TextSpan(
                            text: 'Google',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ]),
                ))),
      ]),
    );
  }
}
