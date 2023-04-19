import 'package:flutter/material.dart';
import 'package:app_moblie_phone_flutter/Page/Login.dart';
import 'package:app_moblie_phone_flutter/assets/colors/myColors.dart';

class ForgotPassword2 extends StatefulWidget {
  const ForgotPassword2({super.key});

  @override
  State<ForgotPassword2> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword2> {
  @override
  Widget build(BuildContext context) {
    final tfNewPassword = Container(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextField(
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.key_outlined),
          labelText: 'Nhập mật khẩu mới',
          hintText: 'Nhập mật khẩu mới',
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );
    final tfNewPasswordConfirm = Container(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextField(
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.key_outlined),
          labelText: 'Nhập lại mật khẩu mới',
          hintText: 'Nhập lại mật khẩu mới',
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );
    final btnHoanthanh = ElevatedButton(
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
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: const Text('Hoàn Thành',
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
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Text(
              'Nhập mật khẩu mới',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          tfNewPassword,
          Text(
            'Nhập mật lại khẩu mới',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          tfNewPasswordConfirm,
          SizedBox(
            height: 30,
          ),
          btnHoanthanh
        ],
      ),
    );
  }
}
