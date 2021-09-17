  import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/config/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileAvatars extends StatelessWidget {
  final String imgUrl;
  final bool? isActive;
  final double? radius;
  final bool? hasBorder;

  const ProfileAvatars({Key? key, required this.imgUrl, this.isActive = false, this.radius = 21, this.hasBorder = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    Stack(
      children: [
        CircleAvatar(
          radius: hasBorder == true ? 23 : 21,
          backgroundColor: Palette.facebookBlue,
          child: CircleAvatar(

          radius: 21,
          backgroundColor: CupertinoColors.systemGrey2,
          backgroundImage:
              CachedNetworkImageProvider(imgUrl),
      ),
        ),
    isActive == true ?  Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              color: Palette.online,
              shape: BoxShape.circle,
              border: Border.all(width: 2,color: Colors.white)
            ),
          )) : const SizedBox.shrink(),

      ]
    );
  }
}
