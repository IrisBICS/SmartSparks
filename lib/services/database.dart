import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartsparks/models/ssuser.dart';
import 'package:smartsparks/models/dataModels.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference topicsCollection = FirebaseFirestore.instance.collection('topics');

  Future updateUser(SSUser ssuser) async {
    usersCollection.doc(ssuser.uid).set({
      'username': ssuser.username,
      'email': ssuser.email,
      'smartPoints': ssuser.smartPoints,
      'sparkPoints': ssuser.sparkPoints,
      'rank': ssuser.rank
    });
  }

  Future createTopic(Topic topic) async {
    topicsCollection.doc().set({
      'creatorID': topic.creatorID,
      'creatorUsername': topic.creatorUsername,
      'title': topic.title,
      'description': topic.description,
      'publishDate': topic.publishDate,
      'deadline': topic.deadline,
      'sparksCount': topic.sparksCount,
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

  List<Topic> _topicsListFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return Topic(
        creatorID: data['creatorID'] ?? '',
        creatorUsername: data['creatorUsername'] ?? '',
        topicID: doc.id,
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        publishDate: data['publishDate'] ?? '',
        deadline: data['deadline'] ?? '',
        sparksCount: data['sparksCount'] ?? 0, //To be replaced by next line
        //sparksCount: //count the number of elements inside the "sparks" collection of this topic
      );
    }).toList();
  }

  Stream<SSUser> get ssuser {
    return usersCollection.doc(uid).snapshots()
      .map(_ssuserFromSnapshot);
  }

  // Topics stream
  Stream<List<Topic>> get topics {
    return topicsCollection.snapshots().map(_topicsListFromQuerySnapshot);
  }

  // Update points
  // -> includes update rank

}