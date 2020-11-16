class Topic {

  final String topicID;
  final String title;
  final String description;
  final String publishDate;
  final String deadline;
  final String creatorID;
  final String creatorUsername;
  final int sparksCount;

  Topic({this.topicID, this.title, this.description, this.publishDate, this.deadline, this.creatorID, this.creatorUsername, this.sparksCount});

}

class Spark {

  final String title;
  final String parentTopic;
  final String sparkID;
  final String description;
  final String publishDate;
  final String creatorID;
  final String creatorRank;
  final List<dynamic> voters;
  final int commentsCount;

  Spark({this.title, this.parentTopic, this.sparkID, this.description, this.publishDate, this.creatorID, this.creatorRank, this.voters, this.commentsCount});

}

class Comment {

  final String commentID;
  final String parentSpark;
  final String title;
  final String body;
  final String publishDate;
  final String authorID;
  final String authorRank;
  final List<dynamic> likes;

  Comment({this.title, this.commentID, this.parentSpark, this.body, this.publishDate, this.authorID, this.authorRank, this.likes});

}