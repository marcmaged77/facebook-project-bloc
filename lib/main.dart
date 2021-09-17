

// @dart=2.9
import 'package:facebook/config/palette.dart';
import 'package:facebook/repositories/Posts/post_repository.dart';
import 'package:facebook/repositories/auth/auth_repository.dart';
import 'package:facebook/screens/createPost/create_post.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:facebook/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'blocs/simple_bloc_observer.dart';
import 'config/cutom_router.dart';
import 'repositories/repositories.dart';



void main()  async{
  //access device
  WidgetsFlutterBinding.ensureInitialized();

//initializing firebase
 await Firebase.initializeApp();

 //
 Bloc.observer = SimpleBlocObserver();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // AuthRepository().logOut();

    return MultiRepositoryProvider(
      providers:[
        RepositoryProvider<AuthRepository>(
            create: (_) => AuthRepository(),
        ),

        RepositoryProvider<PostRepository>(
          create: (_) => PostRepository(),
        ),
        RepositoryProvider<StorageRepository>(
          create: (_) => StorageRepository(),
        ),
      ],
      child:

      MultiBlocProvider(
        providers: [

          BlocProvider<AuthBloc>(
            create: (context)=> AuthBloc(authRepository: context.read<AuthRepository>()),
          )
        ],



        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(

            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Palette.scaffold,
          ),
          // //name routes
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,

          // home: HomeScreen(),
        ),
      ),
    );
  }
}

