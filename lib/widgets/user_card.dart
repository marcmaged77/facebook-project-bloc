import 'package:facebook/models/models.dart';
import 'package:facebook/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';



class UseCard extends StatelessWidget {
  final User user;

  const UseCard({Key? key, required this.user}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileAvatars(imgUrl: user.imageUrl),
          const SizedBox(width: 6,),
          Flexible(child: Text(user.name!, style:TextStyle(fontSize: 16) ,overflow: TextOverflow.ellipsis,))
          
        ],
      ),
    );
  }
}
