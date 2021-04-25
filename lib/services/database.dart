import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectdtb/models/info.dart';
import 'package:projectdtb/models/user.dart';


class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference infoCollection = FirebaseFirestore.instance.collection('info');

  Future updateUserData(String glucose,String name, int strength) async {
    return await infoCollection.doc(uid).set({
      'glucose': glucose,
      'name' : name,
      'strength' : strength,
    });
  }

  // info list from snapshot
List<Info> _infoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return Info(
        name: doc.data()['name'] ?? '',
        strength: doc.data()['strength'] ?? 0,
        glucose: doc.data()['glucose'] ?? '0'
      );
    }).toList();
}

// userdata from snapshot
  TheUserData _theUserDataFromSnapshot(DocumentSnapshot snapshot){
    return TheUserData(
      uid: uid,
      name: snapshot.data()['name'],
      glucoses: snapshot.data()['glucoses'],
      strength: snapshot.data()['strength'],
    );
  }
  //get info stream
Stream<List<Info>> get info {
    return infoCollection.snapshots()
      .map(_infoListFromSnapshot);
}

//get user doc stream
Stream<TheUserData> get userData {
    return infoCollection.doc(uid).snapshots()
    .map(_theUserDataFromSnapshot);
  }

}