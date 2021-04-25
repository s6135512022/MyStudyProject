import 'package:flutter/material.dart';
import 'package:projectdtb/screens/authenticate/authenticate.dart';
import 'package:projectdtb/screens/home/home.dart';
import 'package:projectdtb/models/user.dart';
import 'package:provider/provider.dart';

class  Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<TheUser>(context);
    print(user);
    // return either home or authen
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
