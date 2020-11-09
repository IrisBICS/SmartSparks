import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartsparks/models/dataModels.dart';

class SparkService {

  final String topicID;
  final String sparkID;

  SparkService({this.topicID, this.sparkID});

  final CollectionReference topicsCollection = FirebaseFirestore.instance.collection('topics');

  //Create comment
  Future createComment(Comment comment) async {
    topicsCollection.doc(topicID).collection('sparks').doc(sparkID).collection('comments').doc().set({
      'title': comment.title,
      'body': comment.body,
      'publishDate': comment.publishDate,
      'authorID': comment.authorID,
      'authorRank': comment.authorRank,
      //'likes': []
    });
    topicsCollection.doc(topicID).collection('sparks').doc(sparkID).update({
      'commentsCount': FieldValue.increment(1),
    });
  }

  Spark _sparkFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data();
    return Spark(
      title: data['title'] ?? '',
      parentTopic: topicID,
      sparkID: sparkID,
      description: data['description'] ?? '',
      publishDate: data['publishDate'] ?? '',
      creatorID: data['creatorID'] ?? '',
      creatorRank: data['creatorRank'] ?? '',
      voters: data['voters'] ?? [],
      commentsCount: data['commentsCount'] ?? 0,
    );
  }

  List<Comment> _commentsListFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return Comment(
        commentID: doc.id,
        parentSpark: sparkID,
        title: data['title'],
        body: data['body'] ?? '',
        publishDate: data['publishDate'] ?? '',
        authorID: data['authorID'] ?? '',
        authorRank: data['authorRank'] ?? '',
        likes: data['likes'] ?? [], //Idk if I should put the count
      );
    }).toList();
  }

  //Stream for single spark
  Stream<Spark> get spark {
    return topicsCollection.doc(topicID).collection('sparks').doc(sparkID).snapshots()
      .map(_sparkFromSnapshot);
  }

  //Stream for all comments
  Stream<List<Comment>> get comments {
    return topicsCollection.doc(topicID).collection('sparks').doc(sparkID).collection('comments').snapshots()
      .map(_commentsListFromQuerySnapshot);
  }

}