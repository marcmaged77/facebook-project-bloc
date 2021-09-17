import 'package:firebase_auth/firebase_auth.dart' as auth;


// holds method definitions
abstract class BaseAuthRepository {
  //user getter is a listener to the current state of firebase authientication
  //this method will give as when the user login or log out
  Stream<auth.User?> get user;


Future<auth.User> signUpWithEmailAndPassword({
  required String username,
  required String email,
  required String password,
});


Future<auth.User> loginWithEmailAndPassword({
  required String email,
  required String password


});

Future<void> logOut();

}