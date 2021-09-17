// ignore_for_file: prefer_const_constructors

import 'package:facebook/screens/createPost/create_post.dart';
import 'package:facebook/widgets/profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:facebook/models/models.dart';
import 'package:flutter/painting.dart';

class CreatePostContainer extends StatelessWidget {

  final User currentUser;

  const CreatePostContainer({Key? key, required this.currentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 107.0,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 11, 12, 0),
            child: Row(
              children: [
                ProfileAvatars(imgUrl: currentUser.imageUrl,),
                // CircleAvatar(
                //   radius: 21,
                //   backgroundColor: CupertinoColors.systemGrey2,
                //   backgroundImage:
                //       CachedNetworkImageProvider(currentUser.imageUrl),
                // ),

                const SizedBox(
                  width: 8,
                ),

                // it will expand for the remainig width of the row
                Expanded(
                  child: GestureDetector(
                    onTap: () {

                      Navigator.pushNamed(context, CreatePostScreen.routeName);
                      print('whats on your mind');
                    },
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration.collapsed(
                          hintText: "What's on your mind?",
                          hintStyle: TextStyle(
                              letterSpacing: -0.5, color: Colors.black)),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 11,
          ),
           Divider(
            height: 0,
            thickness: 0,
            color: Colors.grey.shade400,

          ),
          Container(
            padding: EdgeInsets.only(top: 12),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton.icon(
                    onPressed: () => print('live'),
                    icon: const Icon(Icons.videocam, color: Colors.red,size: 20,),
                    label: Text('Live',style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700,letterSpacing: -0.5),)),
                const VerticalDivider(

                  width: 8,
                ),
                FlatButton.icon(
                    onPressed: () => print('photo'),
                    icon: const Icon(Icons.photo_library, color: Colors.green,size: 20,),
                    label: Text('Photo',style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700,letterSpacing: -0.5),)),
                const VerticalDivider(
                  width: 8,
                ),
                FlatButton.icon(

                    onPressed: () => print('Room'),
                    icon: const Icon(Icons.video_call, color: Colors.purpleAccent,size: 20,),
                    label: Text('Room',style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700,letterSpacing: -0.5),)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
