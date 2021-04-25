import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectdtb/models/user.dart';
import 'package:projectdtb/services/database.dart';
import 'package:projectdtb/shared/constants.dart';
import 'package:projectdtb/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> glucoses = ['0-70', '70-100', '100-125', 'more than 126'];


  // form values
  String _currentName;
  String _currentGlucoses;
  int _currnetStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<TheUser>(context);

    return StreamBuilder<TheUserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          TheUserData userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your Information.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  initialValue: userData.name,
                  decoration: InputDecoration(
                    hintText: 'new information',
                    fillColor: Color(0xFFFFFFFF),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xFFFFFFFF), width: 2.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xFFD81B60), width: 2.0)
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20.0),
                // dropdown
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    hintText: 'new information',
                    fillColor: Color(0xFFFFFFFF),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xFFFFFFFF), width: 2.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xFFD81B60), width: 2.0)
                    ),
                  ),
                  value: _currentGlucoses ?? userData.glucoses,
                  items: glucoses.map((glucose) {
                    return DropdownMenuItem(
                      value: glucose,
                      child: Text('$glucose glucoses'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                // slider
                Slider(
                  value: (_currnetStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.red[_currnetStrength ?? 100],
                  inactiveColor: Colors.red[_currnetStrength ?? 100],
                  min: 0,
                  max: 400,
                  divisions: 8,
                  onChanged: (val) =>
                      setState(() => _currnetStrength = val.round()),
                ),
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentGlucoses ?? userData.glucoses,
                          _currentName ?? userData.name,
                          _currnetStrength ?? userData.strength,
                        );
                        Navigator.pop(context);
                      }
                    }
                ),
              ],
            ),
          );

        } else {
            return Loading();
        }

      }
    );
  }
}
