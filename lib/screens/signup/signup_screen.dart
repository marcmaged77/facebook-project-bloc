import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/config/palette.dart';
import 'package:facebook/repositories/auth/auth_repository.dart';
import 'package:facebook/screens/login/cubit/login_cubit.dart';
import 'package:facebook/widgets/button.dart';
import 'package:facebook/widgets/orDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/signup_cubit.dart';

class SignUpScreen extends StatelessWidget {

  static const String routeName = '/signUp';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<SignUpCubit>(
        create: (_) =>
            SignUpCubit(authRepository: context.read<AuthRepository>()),
        child: SignUpScreen(),
      ),
    );
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var height = size.height;
    var width = size.width;







    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status == SignUpStatus.error) {
          showDialog(
            context: context,
            builder: (context) => Platform.isIOS ?

            CupertinoAlertDialog(
              title: Text('Error'),
              content: Text(state.failure.message),
              actions: [
                FlatButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text('Okay'))
              ],
            ) :
            AlertDialog(
              title: Text('Error'),
              content: Text(state.failure.message),
            )
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://firebasestorage.googleapis.com/v0/b/facebook-16b37.appspot.com/o/IMG_3498.jpg?alt=media&token=6ae2525d-0b41-462f-90c2-8bacaf2dfe82',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                          padding: EdgeInsets.only(
                            left: width * 0.060,
                            right: width * 0.060,
                          ),
                          child: TextFormField(
                            onChanged: (value) {
                              context.read<SignUpCubit>().usernameChanged(value);
                              print(value);
                            },
                            validator: (value) => value!.length < 6
                                ? 'Must be at least 6 characters'
                                : null,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelText: "username",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                // borderSide:
                                //     const BorderSide(color: Colors.grey, width: 0.0),
                                borderRadius: BorderRadius.circular(1.0),
                              ),
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.only(
                            left: width * 0.060,
                            right: width * 0.060,
                          ),
                          child: TextFormField(
                            onChanged:(value) {
                              context.read<SignUpCubit>().emailChanged(value);
                              print(value);
                            },
                            validator: (value) => !value!.contains('@')
                                ? 'Please enter a valid email'
                                : null,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelText: "Phone number or email",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                // borderSide:
                                //     const BorderSide(color: Colors.grey, width: 0.0),
                                borderRadius: BorderRadius.circular(1.0),
                              ),
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.only(
                            left: width * 0.060,
                            right: width * 0.060,
                          ),
                          child: TextFormField(
                            onChanged:(value) {
                              context.read<SignUpCubit>().passwordChanged(value);
                              print(value);
                            },
                            validator: (value) => value!.length < 6
                                ? 'Must be at least 6 characters'
                                : null,


                            obscureText: true,
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelText: "password",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                // borderSide:
                                //     const BorderSide(color: Colors.grey, width: 0.0),
                                borderRadius: BorderRadius.circular(1.0),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 50,
                      ),
                      button(
                        radius: 1,
                        widthP: 0.9,
                        textColor: Colors.white,
                        press: () {
                          _submitForm(
                            context,
                            state.status == SignUpStatus.submitting,
                          );

                          print('login');
                        },
                        text: 'Sign Up',
                        color: Palette.facebookBlue,
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    );


  }
  void _submitForm(BuildContext context, bool isSubmitting) {
    if ( _formKey.currentState!.validate() && !isSubmitting) {
      context.read<SignUpCubit>().signUpWithCredential();
    }
  }

}
