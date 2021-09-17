import 'package:facebook/config/palette.dart';
import 'package:facebook/models/models.dart';
import 'package:facebook/widgets/user_card.dart';
import 'package:flutter/material.dart';



class MoreOptions extends StatelessWidget {
  final List<List> _moreOptionsList = const [
[Icons.shield, Colors.deepPurple, "COVID-19 Info Center"],
[Icons.supervisor_account, Colors.cyan, "Friends"],
[Icons.message, Palette.facebookBlue, "Messenger"],
[Icons.flag, Colors.orange, "Pages"],
[Icons.store, Palette.facebookBlue, "Marketplace"],
[Icons.ondemand_video, Palette.facebookBlue, "Watch"],
[Icons.calendar_today_outlined, Colors.red, "Events"],

  ];

  final User currentUser;

  const MoreOptions({Key? key,required this.currentUser}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 200),
      child: ListView.builder(
          itemCount:  1 + _moreOptionsList.length,
          itemBuilder: (BuildContext context, int index){
            if(index == 0 ){
              return Padding(padding: EdgeInsets.symmetric(vertical: 8),
              child: UseCard(user: currentUser,),
              );
            }

final List option = _moreOptionsList[index - 1];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: _Option(icon: option[0], color: option[1], label: option[2], ),
            );

          }),
    );
  }
}


class _Option extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _Option({Key? key,required this.icon,required this.color,required this.label}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child:Row(
        children: [

          Icon(icon,size: 38,color: color,),
          SizedBox(width: 6,),
          Flexible(child: Text(label, style: TextStyle(fontSize:16 ), overflow: TextOverflow.ellipsis,),)
          
        ],
      ) ,



    );
  }
}

