import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectdtb/screens/home/settings_form.dart';
import 'package:projectdtb/services/auth.dart';
import 'package:projectdtb/services/auth.dart';
import 'package:projectdtb/services/database.dart';
import 'package:provider/provider.dart';
import 'package:projectdtb/screens/home/info_list.dart';
import 'package:projectdtb/models/info.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }


    return StreamProvider<List<Info>>.value(
      value: DatabaseService().info,
      child: Scaffold(
        backgroundColor: Colors.purple[50],
        appBar:  AppBar(
          title: Text('Glucose Tracking Buddy'),
          backgroundColor: Colors.purple[400],
          elevation: 0.0,
          actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
            onPressed: () async {
                await _auth.signOut();
            },
          ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            )
        ],
       ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/HW.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: InfoList()
        ),
      ),
    );
  }
}

