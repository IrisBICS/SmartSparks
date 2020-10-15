import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartsparks/models/ssuser.dart';

class DatabaseService {

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future getUser(String uid) async {
    return await usersCollection.doc(uid).get().then((doc) {
      final userData = doc.data();
      return userData != null ? SSUser(uid: uid, username: userData['username'], email: userData['email'], rank: userData['rank'], smartPoints: userData['smartPoints'], sparkPoints: userData['sparkPoints']) : null;
    });
  }

  Future updateUser(SSUser ssuser) async {
    usersCollection.doc(ssuser.uid).set({
      'username': ssuser.username,
      'email': ssuser.email,
      'smartPoints': ssuser.smartPoints,
      'sparkPoints': ssuser.sparkPoints,
      'rank': ssuser.rank
    });
  }
}