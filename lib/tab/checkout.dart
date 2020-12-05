import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Checkout extends StatefulWidget {
  Checkout({Key key}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
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
              "Checkout"
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(CupertinoIcons.check_mark, size: 20,),
              onPressed: () => null,
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
}