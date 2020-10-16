import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartsparks/models/ssuser.dart';
import 'database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  ProviderUser _createUser(User user) {
    return user != null ? ProviderUser(uid: user.uid) : null;
  }

  Stream<ProviderUser> get user {
    return _auth.authStateChanges().map(_createUser);
  }

  Future register(String email, String password) async {
    
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      SSUser ssuser = SSUser(uid: user.uid, username:'New user', email: email, rank: 'Novice Reader', smartPoints: 0, sparkPoints: 0);
      await DatabaseService(uid: user.uid).updateUser(ssuser);
      return user;
    } catch(e) { //Doesn't catch correctly for some reason
      print(e);
      return null;
    }

  }

  Future login(String email, String password) async {

    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return user;
    } catch(e) { //Doesn't catch correctly for some reason
      print(e);
      return null;
    }

  }

  Future logout() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e);
      return null;
    }
  }

}