import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_moblie_phone_flutter/Page/CreateAccount.dart';
import 'package:app_moblie_phone_flutter/Page/ForgotPassword.dart';
import 'package:app_moblie_phone_flutter/assets/colors/myColors.dart';
import 'package:app_moblie_phone_flutter/model/User.dart';

import '../API/api.dart';
import '../model/Product.dart';
import 'MyHomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late UserLogin userLogin = UserLogin();

  final TextEditingController _usernameCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  // @override
  // void initState() {
  //   super.initState();
  //   getUserLoginToAPI('quanghung', 'quanghung').then((value) {
  //     setState(() {
  //       userLogin = value;
  //     });
  //     print(userLogin);
  //   });
  // }

  Widget build(BuildContext context) {
    bool? _isCheck = false;

    final logo = Image(
      image: AssetImage('lib/assets/images/logo.png'),
    );
    final username = TextField(
      controller: _usernameCon,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        labelText: 'Username',
        hintText: 'Username',
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextField(
      controller: _passwordCon,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.key),
        labelText: 'Password',
        hintText: 'Password',
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final siginButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(200, 50),
        side: BorderSide(color: Colors.blue, width: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        elevation: 10.0,
        splashFactory: InkRipple.splashFactory,
      ),
      onPressed: () {
        String _userName = _usernameCon.text.trim().toLowerCase();
        String _password = _passwordCon.text.trim().toLowerCase();
        if (_userName.isEmpty || _password.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Please enter username and password.'),
            duration: Duration(seconds: 2),
          ));
        } else {
          PostUserLoginToAPI(_userName, _password).then((value) {
            userLogin = value;
            print(userLogin);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyHomePage(
                      userLogin: userLogin,
                    )));
          }).catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Incorrect account or password!'),
              duration: Duration(seconds: 2),
            ));
          });
        }
      },
      child: const Text('Sign In',
          style: TextStyle(color: Colors.black, fontSize: 18)),
    );
    final checkBoxRemember = Checkbox(
      value: _isCheck,
      onChanged: (newValue) {
        setState(() {
          _isCheck = newValue ?? false;
        });
      },
      checkColor: Colors.cyanAccent,
    );
    final forgotPass = GestureDetector(
      child: Text('Forgot password'),
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ForgotPassword()));
      },
    );
    final createNewAccount = GestureDetector(
      child: Text(
        'Create a new acount',
        style: TextStyle(
            color: Colors.black54,
            fontSize: 20,
            decoration: TextDecoration.underline),
      ),
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CreateAccount()));

        /// click vào create new a account
      },
    );
    final textWelcomm = Text(
      'Welcom to APP',
      style: TextStyle(
          fontSize: 30, color: Colors.blue, fontWeight: FontWeight.bold),
    );
    return Scaffold(
      backgroundColor: myColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          logo,
          SizedBox(height: 20),
          textWelcomm,
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: username,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: password,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              checkBoxRemember,
              //xu li khi nguoi dung chon),
              Text('Remember me             '),

              forgotPass,
            ],
          ),
          siginButton,
          SizedBox(height: 30),
          createNewAccount,
        ],
      ),
    );
  }
}
