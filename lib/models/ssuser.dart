class ProviderUser {

  final String uid;

  ProviderUser( {this.uid});

}

class SSUser {

  final String uid;
  final String username;
  final String email;
  final String rank;
  final int smartPoints;
  final int sparkPoints;

  SSUser({this.uid, this.username, this.email, this.rank, this.smartPoints, this.sparkPoints});

}