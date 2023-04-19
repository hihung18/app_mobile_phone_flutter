import 'package:flutter/material.dart';
import 'package:app_moblie_phone_flutter/Page/ForgotPassword2.dart';
import 'package:app_moblie_phone_flutter/assets/colors/myColors.dart';

class ForgotPassword1 extends StatefulWidget {
  const ForgotPassword1({super.key});

  @override
  State<ForgotPassword1> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword1> {
  @override
  Widget build(BuildContext context) {
    final tfCodeNumber = Container(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextField(
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.code),
          labelText: 'Code Number',
          hintText: 'Code Number',
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
            .push(MaterialPageRoute(builder: (context) => ForgotPassword2()));
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
              'Xác nhận Email',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          tfCodeNumber,
          SizedBox(
            height: 30,
          ),
          btntieptuc
        ],
      ),
    );
  }
}
