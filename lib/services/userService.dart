import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {

  final String uid;

  UserService({this.uid});

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  String getSmartRank(int smartPoints) {
    if (smartPoints < 10) {
      return 'Novice';
    } else if (smartPoints < 200) {
      return 'Active';
    } else if (smartPoints < 500) {
      return 'Experienced';
    } else if (smartPoints < 1000) {
      return 'Expert';
    } else {
      return 'Smart';
    }
  }

  String getSparkRank(int sparkPoints) {
    if (sparkPoints < 10) {
      return 'Reader';
    } else if (sparkPoints < 200) {
      return 'Contributor';
    } else if (sparkPoints < 500) {
      return 'Brainstormer';
    } else if (sparkPoints < 1000) {
      return 'Innovator';
    } else {
      return 'Spark';
    }
  }

  //Add points & update rank
  Future addPointsAndUpdateRank(int smartPoints, int sparkPoints) {
    DocumentReference userDoc = usersCollection.doc(uid);
    return userDoc.get().then((val) {
      Map<String, dynamic> data = val.data();
      int smartP = data['smartPoints'] + smartPoints;
      int sparkP = data['sparkPoints'] + sparkPoints;
      String newRank = getSmartRank(smartP) + ' ' + getSparkRank(sparkP);
      userDoc.update({
        'smartPoints': smartP,
        'sparkPoints': sparkP,
        'rank': newRank,
      });
    });
  }

} //Blue, Green, Yellow, Orange, Red