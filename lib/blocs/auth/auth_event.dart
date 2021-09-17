part of 'auth_bloc.dart';
//contains all the events that will will be sent to our bloc




@immutable
abstract class AuthEvent extends Equatable{

  const AuthEvent();






  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [];

}

// this event will be called when the firebase updates the current use rthat signed in
class AuthUserChanged extends AuthEvent {
  final auth.User? user;

  const AuthUserChanged({required this.user});

  @override
  List<Object?> get props => [user];

}


//this event will be sent to the bloc when the user wants to log out
class AuthLogOutRequested extends AuthEvent {





}
