import 'package:facebook/models/models.dart';
import 'package:flutter/material.dart';

import 'user_card.dart';

class ContactList extends StatelessWidget {
  final List<User> users;

  const ContactList({Key? key,required this.users}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
// mahma el shasha kebret 3ayzenha 200
constraints: BoxConstraints(maxWidth: 200),
      child:Column(
        children: [
          Row(children: const [
            Expanded(
              child: Text('Contacts',
style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),

              ),
            ),

            Icon(Icons.search, color: Colors.grey,),
            SizedBox(width: 8,),

            Icon(Icons.more_horiz, color: Colors.grey,),

          ],),
          
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10),
                itemCount: users.length,

                itemBuilder: (BuildContext context, int index) {
final User user = users[index];
return Padding(padding: EdgeInsets.symmetric(vertical: 8),
child: UseCard(user:user),);
                }),
          )
        ],
      ) ,
    );
  }
}
