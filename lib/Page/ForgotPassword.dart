import 'package:flutter/material.dart';
import 'package:app_moblie_phone_flutter/Page/ForgotPassword1.dart';
import 'package:app_moblie_phone_flutter/assets/colors/myColors.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    final tfEmail = Container(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextField(
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email_outlined),
          labelText: 'Email',
          hintText: 'Email',
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );
    final btntieptuc = ElevatedButton(
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
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ForgotPassword1()));
      },
      child: const Text('TIẾP TỤC',
          style: TextStyle(color: Colors.black, fontSize: 18)),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black, // set màu cho icon
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Forgot Password',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: myColors.background,
      ),
      backgroundColor: myColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Vui lòng nhập Email đăng kí',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          tfEmail,
          SizedBox(
            height: 30,
          ),
          btntieptuc
        ],
      ),
    );
  }
}
