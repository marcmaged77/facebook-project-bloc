// ignore_for_file: prefer_const_constructors

import 'package:facebook/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:facebook/widgets/widgets.dart';

import 'package:facebook/models/models.dart';

class HomeScreen extends StatelessWidget {

  static const String routeName = '/homeScreen';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => HomeScreen(),
    );
  }


  @override
  Widget build(BuildContext context) {





    return WillPopScope(
        onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Responsive(
          mobile: _HomeScreenMobile(),
          desktop: _HomeScreenDesktop(),

         
        ),
      ),
    );
  }
}



class _HomeScreenMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      //every thing must be silver
      slivers: [
        /////////////////////////////////////////////////////////////////////////////////////////////////    app bar
        Responsive.isDesktop(context) ?
    SliverToBoxAdapter(child: Container()) : SliverAppBar(
            backgroundColor: CupertinoColors.white,
            title: Container(
              margin: EdgeInsets.only(bottom: 6,),
              child: const Text(
                'facebook',
                style: TextStyle(
                    color: Color(0xff20468B),
                    fontWeight: FontWeight.bold,
                    fontSize: 28.5,
                    letterSpacing: -1),
              ),
            ),
            centerTitle: false,
            floating: true,
            actions: [
              //right row
              CircleButton(
                icon: Icons.search,
                onPressed: () {
                  print('search');
                },
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: CircleButton(
                  icon: Icons.switch_account_rounded,
                  onPressed: () {
                    print('messenger');



                  },
                ),
              )
            ],
            bottom: const PreferredSize(
              child: Divider(
                height: 0,
              ),
              preferredSize: Size.fromHeight(0),
            )),

        ///////////////////////////////////////////////////////////////////////////////////////////////

        ///////////////////////////////////////////////////////////////////////////////////////////////// create post container
        SliverToBoxAdapter(
          child: CreatePostContainer(
            currentUser: currentUser,
          ),
        ),
        ///////////////////////////////////////////////////////////////////////////////////////////////

        SliverPadding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          sliver: SliverToBoxAdapter(

            //rooms takes a list from onlineUsers Model
              child: Rooms(onlineUsers: onlineUsers)),
        ),


        SliverPadding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          sliver: SliverToBoxAdapter(
              child: Stories(currentUser: currentUser, stories: stories)),
        ),




        SliverList(
            delegate:SliverChildBuilderDelegate(
                  (context, index){
                final Post post = posts[index];
                return PostContainer(post: post );
              },
              childCount: posts.length,

            )
        ),


        //
        // SliverPadding(
        //   padding: const EdgeInsets.fromLTRB(0, 1000, 0, 5),
        //   sliver: SliverToBoxAdapter(
        //
        //     //rooms takes a list from onlineUsers Model
        //       child: Rooms(onlineUsers: onlineUsers)),
        // ),
        //
        //


      ],
    );
  }
}

class _HomeScreenDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: MoreOptions(currentUser: currentUser),
            ),
          )
        ),
      const   Spacer(),
        Container(
          width: 600,
child:_HomeScreenMobile(),
        ),
        const   Spacer(),

        Flexible(
          flex: 2,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: ContactList(users:onlineUsers),
            ),
          )
        )
      ],

    );
  }
}
