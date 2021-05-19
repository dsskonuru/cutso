import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/router.gr.dart';

final authServiceProvider = Provider((ref) => FirebaseService());

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = true;

  late User _user;

  FirebaseAuth get auth => _auth;
  FirebaseFirestore get firestore => _firestore;

  // Handles Auth
  handleAuth(BuildContext context) {
    _auth.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          debugPrint('User is currently signed out!');
          context.router.root.navigate(LoginRouter());
        } else {
          _user = user;
          _firestore.collection('users').doc(user.uid).get().then(
            (DocumentSnapshot documentSnapshot) {
              if (documentSnapshot.exists) {
                print('Document data: ${documentSnapshot.data()}');
                context.router.root.navigate(HomeRoute());
              } else {
                print('Document does not exist on the database');
                context.router.navigate(RegistrationFormRoute());
              }
            },
          );
        }
      },
    );
  }

  // Sign out
  signOut() {
    _auth.signOut();
  }

  // Sign In
  signIn(AuthCredential authCreds) {
    _auth.signInWithCredential(authCreds);
  }

  // Sign In with OTP
  signInWithOTP(String smsCode, String verId) {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }

  //  Register User to Firebase
  Future<void> registerUser(String fullName, String email) {
    return _firestore
        .collection("users")
        .doc(_user.uid)
        .set({
          'full_name': fullName,
          'email': email,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}

//// LOLOLOLOLOL
