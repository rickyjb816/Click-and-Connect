class Improvement {

  //User Profile Picture -- get from profile
  //User Name -- get from profile
  final String uid; //Improvements UID
  final String userUid; //User's UID for other data
  final String title;//Improvement Title
  final String description;//Improvement Description
  final int upVote;//Improvement Up Vote Counter
  final int downVote;//Improvement Down Vote Counter

  Improvement({this.uid, this.userUid, this.title, this.description, this.upVote, this.downVote});
}

