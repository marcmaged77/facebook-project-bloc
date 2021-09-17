// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/config/palette.dart';
import 'package:facebook/models/models.dart';
import 'package:facebook/widgets/profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostContainer extends StatelessWidget {
  final Post post;

  PostContainer({Key? key, required this.post}) : super(key: key);

  String img =
      'https://pbs.twimg.com/profile_images/716487122224439296/HWPluyjs_400x400.jpg';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //header of post
          ListTile(
            // user image
            leading: ProfileAvatars(
              imgUrl: post.user.imageUrl != false ? post.user.imageUrl : img,
            ),

//user name
            title: Text(
              post.user.name!,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle:
                //time ago
                Row(children: [
              Text('${post.timeAgo} Ago .'),
              Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Icon(
                    Icons.public,
                    color: Colors.grey,
                    size: 17,
                  )),
            ]),
            trailing: IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () => print('More'),
            ),
          ),
          // SizedBox(height: 3,),

          //caption
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(post.caption),
          ),

// to add padding
          post.imageUrl != null ? const SizedBox.shrink() : SizedBox(height: 3),

          post.imageUrl != null
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: CachedNetworkImage(
                    imageUrl: post.imageUrl,
                  ),
                )
              : SizedBox.shrink(),

//post stats
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
            child: Column(
              children: [
                Row(
                  children: [

 //like
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Palette.facebookBlue, shape: BoxShape.circle),
                      child: Icon(
                        Icons.thumb_up,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                    SizedBox(width: 4,),
                    Expanded(
                      child: Text(
                        '${post.likes} Likes',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(width: 8,),

                    Text(
                      '${post.comments} Comments',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width: 8,),
                    Text(
                      '${post.shares} Shares',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          ),

          const Divider(),

          Row(
            children: [

_PostButton(
  icon: Icon(Icons.thumb_up_sharp,
      color:Colors.grey,
      size: 20
  ),
    label: 'Like',
    onTap: () => print('Like')
),

              _PostButton(
                  icon: Icon(Icons.comment,
                      color:Colors.grey,
                      size: 20
                  ),
                  label: 'Comment',
                  onTap: () => print('Comment')
              ),

              _PostButton(
                  icon: Icon(Icons.share,
                      color:Colors.grey,
                      size: 20
                  ),
                  label: 'Share',
                  onTap: () => print('Share')
              ),

            ],

          )



        ],
      ),
    );
  }
}


class _PostButton extends StatelessWidget {

  final Icon icon;
  final String label;
  final VoidCallback onTap;

  const _PostButton({Key? key, required this.icon,required this.label,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:15 ),

            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                SizedBox(width: 4,),
                Text(label)
              ],
            ),
          ),





        ),
      ),
    );
  }
}
