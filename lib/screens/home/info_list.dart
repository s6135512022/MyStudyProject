import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projectdtb/models/info.dart';
import 'package:projectdtb/screens/home/info_tile.dart';

class InfoList extends StatefulWidget {
  @override
  _InfoListState createState() => _InfoListState();
}

class _InfoListState extends State<InfoList> {
  @override
  Widget build(BuildContext context) {

    final info = Provider.of<List<Info>>(context);

    return ListView.builder(
      itemCount: info.length,
      itemBuilder: (context, index) {
        return InfoTile(infor: info[index]);
      },
    );
  }
}
