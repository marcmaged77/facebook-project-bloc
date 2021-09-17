import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/models/failure_model.dart';
import 'package:facebook/repositories/auth/auth_repository.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;


  LoginCubit({required AuthRepository authRepository} ) : _authRepository = authRepository, super(LoginState.initial());



  void emailChanged(String value){

   emit(state.copyWith(email:value, status: LoginStatus.initial));
  }


  void passwordChanged(String value){
    emit(state.copyWith(password:value, status: LoginStatus.initial));

  }

  void loginWithCredential()async{
if(!state.email.isNotEmpty && state.password.isNotEmpty || state.status == LoginStatus.submitting) return;
    //knowing if the user is currently logging
    //login status is submitting
emit(state.copyWith(status: LoginStatus.submitting));
    try{
      
      
      //if succeed
 await _authRepository.loginWithEmailAndPassword(email: state.email, password: state.password);
//then

      //login status is succes
 emit(state.copyWith(status: LoginStatus.success));
    
    }on Failure catch (err){
      emit(state.copyWith(status: LoginStatus.error, failure: err));
    }

  }
}
