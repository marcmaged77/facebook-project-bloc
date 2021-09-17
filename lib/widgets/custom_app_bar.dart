// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/models/models.dart';
import 'package:facebook/widgets/appBar_button.dart';
import 'package:facebook/widgets/custom_Tab_Bar.dart';
import 'package:facebook/widgets/user_card.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final User currentUser;
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomAppBar(
      {Key? key,
      required this.currentUser,
      required this.icons,
      required this.selectedIndex,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black12, offset: Offset(0, 2), blurRadius: 4)
      ]),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text('facebook',
            style: TextStyle(
                color: Color(0xff20468B),
                fontWeight: FontWeight.bold,
                fontSize: 32,
                letterSpacing: -1)),
          ),
          Container(
            height: double.infinity,
            width: 600,
          child: CustomTabBar(
            icons: icons,
            selectedIndex: selectedIndex,
            onTap: onTap,
          ),),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                UseCard(user: currentUser),
                SizedBox(width: 12,),
                CircleButton(icon: Icons.search, iconSize: 25, onPressed: () => print('search'),),
                CircleButton(icon: Icons.messenger, iconSize: 25, onPressed: () => print('messneger'),),





              ],),
          )

        ],
      ) ,
    );
  }
}
