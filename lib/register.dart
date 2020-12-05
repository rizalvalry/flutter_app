import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Register(),
      theme: ThemeData(accentColor: Colors.white70),
    );
  }
}

class Register extends StatefulWidget {
  // Register({Key key}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  bool _termsChecked = false;

  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController hpController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController repasswordController =
      new TextEditingController();

  String username, email, password, repassword;
  final _key = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: new Text(
          "Sign Up",
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        alignment: Alignment(-0.9, -0.9),
        // padding: EdgeInsets.only(bottom: 50.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.grey[100]],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  headerSection(),
                  textSection(),
                  buttonSection(),
                  footerSection(),
                ],
              ),
      ),
    );
  }

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
                  return "please insert username";
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
              controller: hpController,
              cursorColor: Colors.green,
              style: TextStyle(color: Colors.green),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'nomor hp',
                  hintText: 'Handphone'),
            ),
            SizedBox(height: 30.0),
            TextFormField(
              validator: (e) {
                if (e.isEmpty) {
                  return "please insert email";
                }
              },
              onSaved: (e) => email = e,
              controller: emailController,
              cursorColor: Colors.green,
              style: TextStyle(color: Colors.green),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'email',
                  hintText: 'Email'),
            ),
            SizedBox(height: 30.0),
            TextFormField(
              validator: (val) {
                if (val.isEmpty) return 'Empty';
                return null;
              },
              controller: passwordController,
              cursorColor: Colors.green,
              obscureText: true,
              style: TextStyle(color: Colors.green),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password',
                  hintText: 'Password'),
            ),
            SizedBox(height: 30.0),
            TextFormField(
              validator: (val) {
                if (val.isEmpty) {
                  return 'Empty';
                }
                if (val != passwordController.text) return 'Not Match';
                return null;
              },
              controller: repasswordController,
              cursorColor: Colors.green,
              obscureText: true,
              style: TextStyle(color: Colors.green),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'confirm password',
                  hintText: 'Password'),
            ),
            SizedBox(height: 30.0),
            CheckboxListTile(
              title: Text("I have read and agree to the Privacy Police"),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.blue,
              value: _termsChecked,
              onChanged: (bool value) => setState(() => _termsChecked = value),
              subtitle: !_termsChecked
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                      child: Text(
                        'Required field',
                        style:
                            TextStyle(color: Color(0xFFe53935), fontSize: 12),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  regSubmit(String username, email, password, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'username': username,
      'email': email,
      'password': password,
      'link': "http://bee2beehub.com/verifikasi"
    };
    var jsonResponse = null;
    var response = await http.post(
        "http://34.101.199.158:3000/accounts/ffd4c9f2458b534a57250820dbe41ed6f9f352630e0ed1191f6c3aaed3cdf2b6/signup",
        body: data);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      var general = jsonDecode(response.body);
      var statusMessage = general['message'];
      var boolstatus = general['status'];
      // var emailuser = general['createdAccount']['email'];
      print(general);

      final alert = AlertDialog(
        title: boolstatus == true
            ? Text(
                "Pendaftaran berhasil, Segera Verifikasi Email ${general['createdAccount']['email']}")
            : Text(statusMessage),
        content: Text(statusMessage),
        actions: [
          FlatButton(
            child: Text("Oke"),
            onPressed: () {
              boolstatus == true
                  ? Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()),
                      (Route<dynamic> route) => false)
                  : Navigator.pop(context);
            },
          )
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  checking() {
    final form = _key.currentState;
    if (form.validate()) {
      regSubmit(usernameController.text, emailController.text,
          passwordController.text, context);
      setState(() {
        _isLoading = true;
      });
    }
  }

  Container buttonSection() {
    return Container(
      width: 250,
      height: 50.0,
      margin: EdgeInsets.only(bottom: 10.0, left: 15, right: 15),
      child: RaisedButton(
        onPressed: () {
          checking();
        },
        hoverColor: Colors.red,
        disabledColor: Colors.amberAccent,
        color: Colors.green,
        child: Text(
          'Daftar',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
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
      margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
      child: Column(
        children: <Widget>[
          Center(
            child: Text("Atau Daftar Menggunakan"),
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
            child: new InkWell(
                child: new Text('Sudah Punya Akun? Login Disini!'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
