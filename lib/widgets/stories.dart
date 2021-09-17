import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/config/palette.dart';
import 'package:facebook/models/models.dart';
import 'package:facebook/widgets/profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Stories extends StatelessWidget {
  final User currentUser;

  //keda ana leya access lel stories el fel
  final List<Story> stories;

  const Stories({Key? key, required this.currentUser, required this.stories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          scrollDirection: Axis.horizontal,
          itemCount: 1 + stories.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: _StoryCard(
                  currentUser: currentUser,
                  isAddStory: true,
                ),
              );
            }
            final Story story = stories[index - 1];

            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: _StoryCard(
                  story: story,
                ));
          }),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final bool? isAddStory;
  final User? currentUser;
  final Story? story;

   _StoryCard({
    Key? key,
    this.isAddStory = false,
    this.currentUser,
    this.story,
  }) : super(key: key);
   String img =
      'https://pbs.twimg.com/profile_images/716487122224439296/HWPluyjs_400x400.jpg';
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [


        ClipRRect(

          borderRadius:isAddStory == true ? BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)) :  BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl:
            // currentUser?.imageUrl != false ? currentUser?.imageUrl : img,
                isAddStory == true ? currentUser?.imageUrl : story?.imageUrl,
            height:isAddStory == true ? 120 : double.infinity,
            width: 110,

            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: double.infinity,
          width: 110,
          decoration: BoxDecoration(
            gradient: isAddStory == true ? Palette.addStoryGradient : Palette.storyGradient,
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // isAddStory == true ? Positioned(
        //     top: 130,
        //     left: 30,
        //     child: Container(height: 30,color: Colors.red,)): Container(),

        Positioned(
          top:isAddStory == true ? 100 :  8,
          left: isAddStory == true ? 32 : 8,
          child: isAddStory == true
              ? CircleAvatar(
            backgroundColor: Colors.white,
            radius:20,
            child: Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(
                        color: Palette.facebookBlue, shape: BoxShape.circle),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.add),
                      iconSize: 35,
                      color: Colors.white,
                      onPressed: () {
                        print('add story');
                      },
                    ),
                  ),
              )
              : ProfileAvatars(
                  imgUrl: story!.user.imageUrl,
                  hasBorder: story?.isViewed,
                ),
        ),
        Positioned(
          bottom: 8,
          left: 8,
          right: 8,
          child: Text(
            isAddStory == true ? 'Add to Story' : story!.user.name!,
            style: const TextStyle(
                color: CupertinoColors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
