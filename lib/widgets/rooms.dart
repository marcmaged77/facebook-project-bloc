import 'package:facebook/config/palette.dart';
import 'package:facebook/models/models.dart';
import 'package:facebook/widgets/profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Rooms extends StatelessWidget {
  final List<User> onlineUsers;

  const Rooms({Key? key, required this.onlineUsers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      color: Colors.white,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4.0),
          scrollDirection: Axis.horizontal,
          //1 will be the create room button + the length of online user data
          itemCount: 1 + onlineUsers.length,
          itemBuilder: (BuildContext context, int index) {

            //first index is a button
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _CreateRoom(),
              );
            }
            final User user = onlineUsers[index -1];

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: ProfileAvatars(imgUrl: user.imageUrl, isActive: true, ),
            );
          }),
    );
  }
}



//create room button
class _CreateRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: () {
         print('create room');
      },

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      color: Colors.white,
      borderSide: BorderSide(width: 3,color: Colors.blueAccent.shade100,),
      textColor: Palette.facebookBlue,
        child: Row(
          children:const  [
            Icon(Icons.video_call, size: 30, color: Colors.purpleAccent,),
             SizedBox(width: 4,),
            Text('Create\nRoom', style: TextStyle(fontSize: 13),)

          ],


        ),

    );
  }
}
