import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LogInPage extends StatefulWidget {
  final VoidCallback showRegisterPage;

  LogInPage({Key? key, required this.showRegisterPage,})
      : super(key: key);


  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  // text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Future signIn() async {
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: _emailController.text.trim(),
  //     password: _passwordController.text.trim(),
  //   );
  // }


  /// login with email and password with firebase
  /// @param email user email
  /// @param password user password
  //  Future<dynamic> signIn() async {
  //   try {
  //     auth.UserCredential result = await auth.FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email:  _emailController.text.trim(), password: _passwordController.text.trim());
      // DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      // await firestore.collection(USERS).doc(result.user?.uid ?? '').get();
      // User? user;
      // if (documentSnapshot.exists) {
      //   user = User.fromJson(documentSnapshot.data() ?? {});
      // }
      // return user;
  //   } on auth.FirebaseAuthException catch (exception, s) {
  //     debugPrint(exception.toString() + '$s');
  //     switch ((exception).code) {
  //       case 'invalid-email':
  //         return 'Email address is malformed.';
  //       case 'wrong-password':
  //         return 'Wrong password.';
  //       case 'user-not-found':
  //         return 'No user corresponding to the given email address.';
  //       case 'user-disabled':
  //         return 'This user has been disabled.';
  //       case 'too-many-requests':
  //         return 'Too many attempts to sign in as this user.';
  //     }
  //     return 'Unexpected firebase error, Please try again.';
  //   } catch (e, s) {
  //     debugPrint(e.toString() + '$s');
  //     return 'Login failed, Please try again.';
  //   }
  // }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> signIn(context) async {

    try {
      final User? firebaseUser = (await _firebaseAuth
          .signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text)
          .catchError((err) {

        return null;
      }).catchError((onError) {

        return null;
      }))
          .user;
      if (firebaseUser != null) {
        //save user info to firebase database


      } else {

        _firebaseAuth.signOut();

      }
    } on PlatformException catch (e) {
      Navigator.pop(context);
      print(e.message);
    } on FirebaseAuthException catch (e) {
      // Your logic for Firebase related exceptions
      Navigator.pop(context);
      print("firebase $e");
    } on Exception catch (e) {
      Navigator.pop(context);
      print(e);
      // if (e.code == 'user-not-found') {
      //   displayMessage(context, 'No user found for that email.');
      // } else if (e.code == 'wrong-password') {
      //   displayMessage(context, 'Wrong password provided for that user.');
      // }
    }
  }





  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/banks.jpeg',
                ),
                // hellow again!
                const SizedBox(
                  height: 25,
                ),
                Text('Hello Again!',
                    style: GoogleFonts.alikeAngular(fontSize: 36)),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Welcome back, you\'ve been missed!',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                //email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: (){
                      signIn(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(23),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white),
                          color: Colors.pinkAccent),
                      child: const Center(
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a member? '),
                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: const Text(
                        'Register Now',
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
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