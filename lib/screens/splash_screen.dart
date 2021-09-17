import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child:

//getting the current auth state
            BlocListener<AuthBloc, AuthState>(
          listenWhen: (prevState, state) => prevState.status != state.status,
          // Prevent listener from triggering if status did not change

          listener: (context, state)
          {
            if (state.status == AuthStatus.unauthenticated) {
               Future.delayed(const Duration(seconds: 1), (){

                 Navigator.of(context).pushNamed(LoginScreen.routeName);

               });
            } else if (state.status == AuthStatus.authenticated) {
              //go to home screen

              Navigator.of(context).pushNamed(NavScreen.routeName);
            }

            print(state);
          },
          child: Scaffold(
            body: Center(
              child:
              CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                radius: 50,
                backgroundImage: CachedNetworkImageProvider('https://firebasestorage.googleapis.com/v0/b/facebook-16b37.appspot.com/o/logo-facebook.png?alt=media&token=cc07b96d-c186-4be6-af43-940a8e19449e'),
              ),
            ),
          ),
        ),

        //to prevent user from going back
        onWillPop: () async => false);
  }
}
