import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/repositories/repositories.dart';
import 'package:facebook/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:facebook/models/models.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseFirestore _firebaseFirestore;
  final auth.FirebaseAuth _firebaseAuth;

  AuthRepository({
    FirebaseFirestore? firebaseFirestore,
    auth.FirebaseAuth? firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  //listen to update
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  ///////////////////////////////////////////////////////////////Sign Up ///////////////////////////////////////////////////////
  @override
  Future<auth.User> signUpWithEmailAndPassword(
      {required String username,
      required String email,
      required String password}) async {
    try {
      //to create user in firebase
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      final user = credential.user;

      //add to firestore database
      _firebaseFirestore.collection('users').doc(user!.uid).set({
        'username': username,
        'email': email,
      });

      return user;
    }


    /////////////error handling ///////////
    on auth.FirebaseAuthException catch (err) {
      throw Failure(code: err.code, message: err.message!);
    }
    on PlatformException catch (err) {
      throw Failure(code: err.code, message: err.message!);
    }
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




  ////////////////////////////////////////////////////////////// Login /////////////////////////////////////////////////////////////////////
  @override
  Future<auth.User> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;


      /////////////error handling ///////////
    } on auth.FirebaseAuthException catch (err) {
      throw Failure(code: err.code, message: err.message!);
    } on PlatformException catch (err) {
      throw Failure(code: err.code, message: err.message!);
    }
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}


