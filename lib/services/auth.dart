import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future register(String email, String password) async {
    
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
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

}