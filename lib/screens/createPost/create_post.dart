// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:facebook/blocs/auth/auth_bloc.dart';
import 'package:facebook/data/data.dart';
import 'package:facebook/helpers/helpers.dart';
import 'package:facebook/models/models.dart';
import 'package:facebook/repositories/Posts/post_repository.dart';
import 'package:facebook/repositories/repositories.dart';
import 'package:facebook/screens/createPost/cubit/create_posts_cubit.dart';
import 'package:facebook/widgets/profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class CreatePostScreen extends StatelessWidget {
  static const String routeName = '/createPost';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (context, _, __) => BlocProvider<CreatePostsCubit>(
          create: (_) => CreatePostsCubit(
              postRepository: context.read<PostRepository>(),
              storageRepository: context.read<StorageRepository>(),
              AuthBloc: context.read<AuthBloc>()),
          child: CreatePostScreen()),
    );
  }


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    var height = size.height;
    var width = size.width;
    return

        BlocConsumer<CreatePostsCubit, CreatePostsState>(
          listener: (context, state){


            if(state.status == CreatePostStatus.success){
              _formKey.currentState!.reset();
              context.read<CreatePostsCubit>().reset();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 1),
                  content: Text('PostCreated')));
            }
            else if(state.status == CreatePostStatus.error ){
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
          builder:(context, state){

            return GestureDetector(

              onTap: (){
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'Create Post',
                    style: TextStyle(color: Colors.black),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  elevation: 0.7,
                  actions: [
                    FlatButton(
                      onPressed: () {
_submitForm(context , state.postImage!, state.status == CreatePostStatus.submitting);


                        print('post');
                      },
                      child: const Text(
                        'Post',
                        style: TextStyle(fontSize: 17),
                      ),
                    )
                  ],
                  leading: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                      print('go back');
                    },
                    color: Colors.black,
                  ),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    height: height,
                    child: Stack(

                        children: [
                          Container(
                            child: Form(
key:_formKey,
                              child: Column(
                                children: [
                                  topCreatePost(),


                                  Container(
                                      padding: EdgeInsets.only(left: 10,right: 10),
                                      child: TextFormField(
                                        onChanged: (value) => context.read<CreatePostsCubit>().captionChanged(value),
                                        validator: (value) => value!.trim().isEmpty ? 'Caption cannot be empty.'
                                            : null ,


                                        keyboardType: TextInputType.multiline,
                                        maxLines: 4,
                                        decoration: InputDecoration.collapsed(
                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                          hintText: "What's on your mind?",
                                          fillColor: Colors.white,

                                        ),

                                      )),
                                  Container(
                                    height: height / 4,
                                    width: width /2,
                                    // color: Colors.grey,
                                    child: state.postImage != null ?  Image.file(state.postImage!, fit: BoxFit.cover)
                                        : Icon(Icons.image , color: Colors.grey,size: 120,),
                                  ),

                                  if(state.status == CreatePostStatus.submitting)
                                    const LinearProgressIndicator(),




                                ],
                              ),
                            ),
                          ),
                          DragbleScrollBottom(),
                        ]),
                  ),
                ),
              ),
            );
          }

        );
  }
  void _submitForm(BuildContext context, File postImage, bool isSubmitting) async{
    if(_formKey.currentState!.validate() && postImage != null && !isSubmitting){
      context.read<CreatePostsCubit>().submit();

    }


  }

}

void _selectedPostImage(BuildContext context) async{
  final pickedFile = await ImageHelper.pickImageFromGallery(
    context: context,
    cropStyle: CropStyle.rectangle,
    title: 'Create Post',
  );
  if (pickedFile != null) {
    context.read<CreatePostsCubit>().postImageChanged(pickedFile);
  }

}

class topCreatePost extends StatelessWidget {
  const topCreatePost({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfileAvatars(
        imgUrl: currentUser.imageUrl,
      ),
      title: Text(
        currentUser.name!,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // _buildSheet(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 5, right: 2, top: 5),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(children: [
                    const Icon(
                      Icons.public,
                      color: Colors.grey,
                      size: 17,
                    ),
                    const Text('Public'),
                    const Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Colors.grey,
                      size: 17,
                    ),
                  ]),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 5, right: 2, top: 5),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4)),
                child: Row(children: [
                  const Icon(
                    Icons.add,
                    color: Colors.grey,
                    size: 17,
                  ),
                  const Text('Album'),
                  const Icon(
                    Icons.arrow_drop_down_sharp,
                    color: Colors.grey,
                    size: 17,
                  ),
                ]),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class DragbleScrollBottom extends StatelessWidget {
  const DragbleScrollBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.2,
        maxChildSize: 1,
        initialChildSize: 0.5,
        builder: (context, controller) => Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),

            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),

              child: Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
color: Colors.white

                    ),
                    child: Column(
                      children: [


                        ListTile(
                          onTap: () {
                            _selectedPostImage(context);

                          },
                          leading: Icon(
                            Icons.photo_library,
                            color: Colors.green,
                            size: 30,
                          ),
                          title: Text('Photo/Video'),
                        ),
                        ListTile(
                          onTap: () {},

                          leading: Icon(
                            Icons.people_outline_sharp,
                            color: Colors.blue,
                            size: 30,
                          ),
                          title: Text('Tag People'),
                        ),
                        ListTile(
                          onTap: () {},

                          leading: Icon(
                            Icons.tag_faces_outlined,
                            color: Colors.yellow,
                            size: 30,
                          ),
                          title: Text('Feeling/Activity'),
                        ),
                        ListTile(
                          onTap: () {},

                          leading: Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 30,
                          ),
                          title: Text('Check In'),
                        ),
                        ListTile(
                          onTap: () {},

                          leading: Icon(
                            Icons.video_call,
                            color: Colors.red,
                            size: 30,
                          ),
                          title: Text('Live Video'),
                        ),
                        ListTile(
                          onTap: () {},

                          leading: Icon(
                            Icons.font_download_outlined,
                            color: Colors.cyan,
                            size: 30,
                          ),
                          title: Text('Background Color'),
                        ),
                        ListTile(
                          onTap: () {},

                          leading: Icon(
                            Icons.camera_alt,
                            color: Colors.blue,
                            size: 30,
                          ),
                          title: Text('Camera'),
                        ),
                        ListTile(
                          onTap: () {},

                          leading: Icon(
                            Icons.gif,
                            color: Colors.green,
                            size: 30,
                          ),
                          title: Text('GIF'),
                        ),
                        ListTile(
                          onTap: () {},

                          leading: Icon(
                            Icons.reviews,
                            color: Colors.red,
                            size: 30,
                          ),
                          title: Text('Ask for Recommendations'),
                        ),
                        ListTile(
                          onTap: () {},

                          leading: Icon(
                            Icons.price_change,
                            color: Colors.green,
                            size: 30,
                          ),
                          title: Text('Sell Something'),
                        ),
                        ListTile(
                          onTap: () {},

                          leading: Icon(
                            Icons.calendar_today,
                            color: Colors.red,
                            size: 30,
                          ),
                          title: Text('Tag Event'),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

}

void _buildSheet(context) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      context: context,
      builder: (BuildContext c) {
        return Container();
      });
}


