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
    });
    topicsCollection.doc(topicID).collection('sparks').doc(sparkID).update({
      'commentsCount': FieldValue.increment(1),
    });
  }

  //Toggle vote-unvote spark
  Future changeSparkVote(dynamic uid, bool isUpVoted) async {
    DocumentReference sparkDoc = topicsCollection.doc(topicID).collection('sparks').doc(sparkID);
    if (isUpVoted) { //If already voted, remove the vote
      sparkDoc.update({
        'voters': FieldValue.arrayRemove([uid]),
      });
    } else { //Else add the vote
      sparkDoc.update({
        'voters': FieldValue.arrayUnion([uid]),
      });
    }
  }

  //Toggle like-unlike comment
  Future changeCommentLike(dynamic uid, bool isLiked, String commentID) async {
    DocumentReference commentDoc = topicsCollection.doc(topicID).collection('sparks').doc(sparkID).collection('comments').doc(commentID);
    if (isLiked) { //If already voted, remove the vote
      commentDoc.update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else { //Else add the vote
      commentDoc.update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
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
        likes: data['likes'] ?? [],
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