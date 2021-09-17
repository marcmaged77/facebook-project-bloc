import 'package:flutter_bloc/flutter_bloc.dart';



//cubit are methods yield in the state without events
class SimpleBlocObserver extends BlocObserver {



  //
  @override
  void onEvent(Bloc bloc, Object? event) {
    print(event);
    super.onEvent(bloc, event);
  }



  //is when bloc state is changin from one state to another state
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  Future<void> onError(
      Cubit cubit,
      Object error,
      StackTrace stackTrace,
      ) async {
    print(error);
    super.onError(cubit, error, stackTrace);
  }
}