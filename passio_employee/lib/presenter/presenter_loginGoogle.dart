import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

Future<String> signInWithGoogle() async{
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await  googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString('displayName', '${user.displayName}');
//     prefs.setString('email', '${user.email}');
//
// //    print('signInWithGoogle succeeded: $user');
//     print('===========================');
//     print('Login Google Successed');
//     print('UserID: ${user.email}');
//     print('DisplayName: ${user.displayName}');
//     print('PhoneNumber: ${user.phoneNumber}');
//     print('===========================');
    return '${user.email}';
  }

  return null;
}