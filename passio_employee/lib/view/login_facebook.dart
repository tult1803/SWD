import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:passioemployee/view/ScreenFacebook.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // return MaterialApp(
//     // );
//   }
// }

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoggedIn = false;
  String _message;
  final _auth = FirebaseAuth.instance;
  final _facebooklogin = FacebookLogin();

  Future _loginWithFacebook() async {
    _facebooklogin.loginBehavior = FacebookLoginBehavior.nativeOnly;
    final result = await _facebooklogin.logIn(['email']);
    if (result.status == FacebookLoginStatus.loggedIn) {
      final credential = FacebookAuthProvider.credential(
        result.accessToken.token,
      );
      final user = (await _auth.signInWithCredential(credential)).user;
      setState(() {
        _message = "Logged in as ${user.displayName}";
        _isLoggedIn = true;
      });
    }
  }

  Future _logout() async {
    await _auth.signOut();
    await _facebooklogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  Future _checkLogin() async {
    final user = await _auth.currentUser;
    if (user != null) {
      setState(() {
        _message = "Logged in as ${user.displayName}";
        _isLoggedIn = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoggedIn
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_message),
            SizedBox(height: 12.0),
            OutlineButton(
              onPressed: () {
                _logout();
              },
              child: Text('Logout'),
            ),
          ],
        )
            : RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScreenFacebook()),
            );
          },
          color: Colors.blue,
          textColor: Colors.white,
          child: Text('Login with Facebook'),
        ),
      ),
    );
  }
}
