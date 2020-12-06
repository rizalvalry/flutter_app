import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/main.dart';
import 'package:flutter_app/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username, password;
  final _key = new GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        alignment: Alignment(-0.9, -0.9),
        // padding: EdgeInsets.only(bottom: 50.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.white], //ups cancel gradient
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  headerSection(),
                  textSection(),
                  forgotButton(),
                  buttonSection(),
                  footerSection(),
                ],
              ),
      ),
    );
  }

  signIn(String username, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'username': username, 'password': password};
    var jsonResponse = null;
    var response = await http.post(
        "http://34.101.199.158:3000/accounts/ffd4c9f2458b534a57250820dbe41ed6f9f352630e0ed1191f6c3aaed3cdf2b6/signin",
        body: data);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MainPage()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  Container forgotButton() {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(children: <Widget>[
          new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              new Text("Remember me"), 
              new Text("Lupa Password?", style: TextStyle(color: Colors.green),)]),
        ]));
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      signIn(usernameController.text, passwordController.text);
      print("$username, $password");
      setState(() {
        _isLoading = true;
      });
    }
  }

  Container buttonSection() {
    return Container(
      // width: MediaQuery.of(context).size.width,
      width: 250,
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0, left: 3.0, right: 3.0),
      child: RaisedButton(
        onPressed: () {
          check();
        },
        elevation: 0.0,
        hoverColor: Colors.red,
        disabledColor: Colors.green,
        color: Colors.green,
        child: Text("Login",
            style: TextStyle(color: Colors.white, fontSize: 20.0)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (e) {
                if (e.isEmpty) {
                  return "please Insert username";
                }
              },
              onSaved: (e) => username = e,
              controller: usernameController,
              cursorColor: Colors.green,
              style: TextStyle(color: Colors.green),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username',
                  hintText: 'Username'),
            ),
            SizedBox(height: 30.0),
            TextFormField(
              validator: (e) {
                if (e.isEmpty) {
                  return "please Insert password";
                }
              },
              onSaved: (e) => password = e,
              controller: passwordController,
              cursorColor: Colors.green,
              obscureText: true,
              style: TextStyle(color: Colors.green),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password',
                  hintText: 'Password'),
            ),
          ],
        ),
      ),
    );
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Image.asset('assets/images/flutter-logo.png'),
    );
  }

  Container footerSection() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              "Atau Login Dengan",
              style: TextStyle(color: Colors.black54)
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/images/facebook.png'),
              Image.asset('assets/images/google.png'),
              Image.asset('assets/images/tweeter.png'),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          Center(
              child: InkWell(
            child: RichText(
              text: TextSpan(
                text: 'Belum Punya Akun? Daftar',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
                children: <TextSpan>[
                  TextSpan(
                      text: ' Disini!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green)),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Register()),
              );
            },
          )),
        ],
      ),
    );
  }
}
