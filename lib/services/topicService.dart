import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartsparks/models/dataModels.dart';

class TopicService {

  final String topicID;

  TopicService({this.topicID,});

  final CollectionReference topicsCollection = FirebaseFirestore.instance.collection('topics');

  Future createSpark(Spark spark) async {
    topicsCollection.doc(topicID).collection('sparks').doc().set({
      'creatorID': spark.creatorID,
      'creatorRank': spark.creatorRank,
      'title': spark.title,
      'description': spark.description,
      'publishDate': spark.publishDate,
      'commentsCount': spark.commentsCount,
    });
    topicsCollection.doc(topicID).update({
      'sparksCount': FieldValue.increment(1),
    });
  }

  Future deleteTopic() async {
    topicsCollection.doc(topicID).delete();
  }

  Topic _topicFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return data != null ? Topic(
      creatorID: data['creatorID'] ?? '',
      creatorUsername: data['creatorUsername'] ?? '',
      topicID: topicID,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      publishDate: data['publishDate'] ?? '',
      deadline: data['deadline'] ?? '',
      sparksCount: data['sparksCount'] ?? 0,
    ) : null;
  }

  List<Spark> _sparksListFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return Spark(
        parentTopic: topicID,
        creatorID: data['creatorID'] ?? '',
        creatorRank: data['creatorRank'] ?? '',
        sparkID: doc.id,
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        publishDate: data['publishDate'] ?? '',
        voters: data['voters'] ?? [],
        commentsCount: data['commentsCount'] ?? 0,
      );
    }).toList();
  }

  //Stream for single topic
  Stream<Topic> get topic {
    return topicsCollection.doc(topicID).snapshots()
      .map(_topicFromSnapshot);
  }

  //Stream for all sparks
  Stream<List<Spark>> get sparks {
    return topicsCollection.doc(topicID).collection('sparks').snapshots()
      .map(_sparksListFromQuerySnapshot);
  }

}