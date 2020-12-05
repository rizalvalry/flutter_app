import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/login.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF8BC34A),
          // toolbarHeight: 30,
          elevation: 0,
          titleSpacing: 20,
          title: Container(
            margin: new EdgeInsets.only(bottom: 15.0, top: 15.0),
            child: Text(
              "Settings"
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(CupertinoIcons.person_solid, size: 20,),
              onPressed: () {
                _logOutModalBottom(context);
              },
            ),
          ],
        ),
        body: new ListView(
          children: <Widget>[
            Container(
              height: 200,
              child: _newStackProperty(),
            ),
            new Padding(
              padding: EdgeInsets.only(bottom: 20.0),
            ),
          ],
        )
        );
  }

Widget _newStackProperty() => Container(
        constraints: BoxConstraints.expand(height: 160),
        child: Stack(
          children: <Widget>[
            Container(
              // height: 350,
              // margin:  EdgeInsets.only(top: 25),
              // padding: EdgeInsets.only(top: 200, bottom: 100),
              decoration: new BoxDecoration(
                color: Color(0xFF8BC34A),
                boxShadow: [new BoxShadow(blurRadius: 3.0)],
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(19.0)),
              ),
            ),
          ],
        ),
      );

  void _logOutModalBottom(context) {
    showModalBottomSheet(context: context, builder: (BuildContext bc) {
      return new Container(
        color: Colors.transparent,
        child: new Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.settings_power,), title: Text("Log Out"),
                onTap: () {
                   // sharedPreferences.clear();
  //             // sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
                },),
              // new ListTile(leading: new Icon(Icons.home,), title: Text("Casas"),),
              // new ListTile(leading: new Icon(Icons.fastfood), title: Text("Comidas"),)
            ],),),
      );
    });
  }

}
