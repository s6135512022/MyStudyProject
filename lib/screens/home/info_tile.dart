import 'package:flutter/material.dart';
import 'package:projectdtb/models/info.dart';

class InfoTile extends StatelessWidget {

  final Info infor;
  InfoTile ({ this.infor });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.purple[infor.strength],
          ),
          title: Text(infor.name),
          subtitle: Text('You have ${infor.glucose} mg/dl of Blood Glucose'),
        ),
      )
    );
  }
}
