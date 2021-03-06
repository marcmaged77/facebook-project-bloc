import 'package:facebook/screens/createPost/create_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:facebook/screens/screens.dart';

//
class CustomRouter {
//
//

  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => const Scaffold(),
        );
      case SplashScreen.routeName:
        return SplashScreen.route();

      case HomeScreen.routeName :
        return HomeScreen.route();

      case LoginScreen.routeName :
        return LoginScreen.route();

      case SignUpScreen.routeName :
        return SignUpScreen.route();

      case NavScreen.routeName :
        return NavScreen.route();

      case CreatePostScreen.routeName :
        return CreatePostScreen.route();

      default:
        return _errorRoute();
    }


  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Something went wrong!'),
        ),
      ),
    );
  }


}