import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/repositories/auth/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

//will take the events and yeild a new state

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  late StreamSubscription<auth.User?> _userSubscription;

  //when Authbloc is initiated at first we dont know the current state of the user
  AuthBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(AuthState.unknown()) {
    _userSubscription =
        _authRepository.user.listen((user) => add(AuthUserChanged(user: user)));
  }



  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthUserChanged) {
      yield* _mapAuthUserChangedToState(event);

    } else if (event is AuthLogOutRequested) {
      await _authRepository.logOut();
    }
  }

//
Stream<AuthState> _mapAuthUserChangedToState(AuthUserChanged event) async* {
    yield event.user != null ? AuthState.authenticated(user: event.user!)
        :   AuthState.unauthenticated();
}

}
