part of 'auth_bloc.dart';
//contains the state of the app

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
///// instance of firebase user/////
  final auth.User? user;
  final AuthStatus status;

  const AuthState({
    this.user,
    this.status = AuthStatus.unknown,
  });






  //three states
  factory AuthState.unknown() => const AuthState();

  factory AuthState.authenticated({required auth.User user}) {
    return AuthState(user: user, status: AuthStatus.authenticated);
  }

  factory AuthState.unauthenticated() => const AuthState(status:  AuthStatus.unauthenticated );





  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [user, status];
}
