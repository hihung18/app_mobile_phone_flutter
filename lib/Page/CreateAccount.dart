import 'package:flutter/material.dart';
import 'package:app_moblie_phone_flutter/API/api.dart';
import 'package:app_moblie_phone_flutter/Page/Login.dart';
import 'package:app_moblie_phone_flutter/assets/colors/myColors.dart';
import 'package:app_moblie_phone_flutter/model/User.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _userNameCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  final TextEditingController _passwordConfirmCon = TextEditingController();
  void CreateAccountSuccessAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Create Account Success"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final btnSignUpButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        // fixedSize: Size(200, 50),
        side: BorderSide(color: Colors.blue, width: 4),
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        elevation: 10.0,
        splashFactory: InkRipple.splashFactory,
      ),
      onPressed: () {
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => MyHomePage()));
      },
      child: const Text('SIGN UP',
          style: TextStyle(color: Colors.black, fontSize: 18)),
    );
    final btnReturnButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        // fixedSize: Size(200, 50),
        side: BorderSide(color: Colors.blue, width: 4),
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        elevation: 10.0,
        splashFactory: InkRipple.splashFactory,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('RETURN',
          style: TextStyle(color: Colors.black, fontSize: 18)),
    );
    return Scaffold(
      backgroundColor: myColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Image(
            image: AssetImage('lib/assets/images/logo.png'),
          ),
          SizedBox(height: 30),
          Text(
            'Create Account',
            style: TextStyle(
                fontSize: 30, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              controller: _userNameCon,
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.supervised_user_circle),
                labelText: 'User Name',
                hintText: 'User Name',
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              controller: _emailCon,
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'Email',
                hintText: 'Your Email',
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              controller: _passwordCon,
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.key),
                labelText: 'Password',
                hintText: 'Password',
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: TextField(
              controller: _passwordConfirmCon,
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.key),
                labelText: 'Confirm Password',
                hintText: 'Confirm Password',
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // fixedSize: Size(200, 50),
                  side: BorderSide(color: Colors.blue, width: 4),
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.white,
                  elevation: 10.0,
                  splashFactory: InkRipple.splashFactory,
                ),
                onPressed: () {
                  String username = _userNameCon.text.trim();
                  String email = _emailCon.text.trim();
                  String password = _passwordCon.text.trim().toLowerCase();
                  String passwordConfirm =
                      _passwordConfirmCon.text.trim().toLowerCase();
                  if (username.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please enter username.'),
                      duration: Duration(seconds: 2),
                    ));
                  } else if (email.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please enter email.'),
                      duration: Duration(seconds: 2),
                    ));
                  } else if (password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please enter password.'),
                      duration: Duration(seconds: 2),
                    ));
                  } else if (passwordConfirm.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please enter password confirm.'),
                      duration: Duration(seconds: 2),
                    ));
                  } else if (password != passwordConfirm) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('password is not matching.'),
                      duration: Duration(seconds: 2),
                    ));
                  } else {
                    ///
                    UserSignUp userSignUp = UserSignUp();
                    userSignUp.id = 0;
                    userSignUp.username = username;
                    userSignUp.email = email;
                    userSignUp.roles = 'ROLE_USER';
                    userSignUp.password = password;
                    print('UserSignUp = $userSignUp');
                    PostUserSignUp(userSignUp);
                    CreateAccountSuccessAlertDialog(context);
                  }
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) => MyHomePage()));
                },
                child: const Text('SIGN UP',
                    style: TextStyle(color: Colors.black, fontSize: 18)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // fixedSize: Size(200, 50),
                  side: BorderSide(color: Colors.blue, width: 4),
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.white,
                  elevation: 10.0,
                  splashFactory: InkRipple.splashFactory,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('RETURN',
                    style: TextStyle(color: Colors.black, fontSize: 18)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
