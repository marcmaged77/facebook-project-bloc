import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/models/failure_model.dart';
import 'package:facebook/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';


class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;


  SignUpCubit({required AuthRepository authRepository} ) : _authRepository = authRepository, super(SignUpState.initial());

  void usernameChanged(String value){

    emit(state.copyWith(username:value, status: SignUpStatus.initial));
  }

  void emailChanged(String value){

    emit(state.copyWith(email:value, status: SignUpStatus.initial));
  }


  void passwordChanged(String value){
    emit(state.copyWith(password:value, status: SignUpStatus.initial));

  }

  void signUpWithCredential()async{
    if(!state.email.isNotEmpty && state.password.isNotEmpty && state.username.isNotEmpty || state.status == SignUpStatus.submitting) return;
    //knowing if the user is currently logging
    //login status is submitting
    emit(state.copyWith(status: SignUpStatus.submitting));
    try{


      //if succeed
      await _authRepository.signUpWithEmailAndPassword(
          username: state.username,
          email: state.email, password: state.password);
//then

      //login status is succes
      emit(state.copyWith(status: SignUpStatus.success));

    }on Failure catch (err){
      emit(state.copyWith(status: SignUpStatus.error, failure: err));
    }

  }

}
