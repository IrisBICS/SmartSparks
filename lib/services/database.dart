import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartsparks/models/ssuser.dart';
import 'package:smartsparks/models/dataModels.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  //final CollectionReference topicsCollection = FirebaseFirestore.instance.collection('topics');

  /* Future<SSUser> getUser(String uid) async {
    return usersCollection.doc(uid).get().then((doc) {
      final userData = doc.data();
      return userData != null ? SSUser(uid: uid, username: userData['username'], email: userData['email'], rank: userData['rank'], smartPoints: userData['smartPoints'], sparkPoints: userData['sparkPoints']) : null;
    });
  } */

  Future updateUser(SSUser ssuser) async {
    usersCollection.doc(ssuser.uid).set({
      'username': ssuser.username,
      'email': ssuser.email,
      'smartPoints': ssuser.smartPoints,
      'sparkPoints': ssuser.sparkPoints,
      'rank': ssuser.rank
    });
  }

  SSUser _ssuserFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return SSUser(
      uid: uid, 
      username: data['username'], 
      email: data['email'], 
      rank: data['rank'], 
      smartPoints: data['smartPoints'], 
      sparkPoints: data['sparkPoints']
    );
  }

  Stream<SSUser> get ssuser {
    return usersCollection.doc(uid).snapshots()
      .map(_ssuserFromSnapshot);
  }

  // Topics stream
/*   Stream<QuerySnapshot> get topics {
    return topicsCollection.snapshots();
  } */

  // Sparks stream

  // Comments stream

  // Update points
  // -> includes update rank

  // Update topic

  // Create spark

  // Create comment

  // Get Topics

  // Get Sparks

  // Get Comments

}