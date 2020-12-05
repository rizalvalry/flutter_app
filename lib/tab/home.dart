import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/tab/body/banner.dart' as banner;
import 'package:flutter_app/tab/body/category.dart';
import 'package:flutter_app/tab/body/product.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = false;

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
            // margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
            // color: Colors.white,
            margin: new EdgeInsets.only(bottom: 15.0, top: 15.0),
            child: TextField(
              autofocus: false,
              style: TextStyle(fontSize: 15.0, color: Color(0xFFbdc6cf)),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onChanged: (text) {
                text = text.toLowerCase();
                setState(() {
                  print("I'm still progress and but its time to tired, sorry I Don't Have to much Time");
                });
              },
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.message),
              onPressed: () => null,
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () => null,
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => null,
            ),
          ],
        ),
        body: new ListView(
          children: <Widget>[
            Container(
              height: 200,
              child: _stackProperty(),
            ),
            new Padding(
              padding: EdgeInsets.only(bottom: 10.0),
            ),
            Container(
              height: 325,
              child: Category(),
            ),
            new Padding(
              padding: EdgeInsets.only(bottom: 10.0),
            ),
            Container(
              height: 400,
              child: Product(),
            ),
          ],
        ));
  }

  Widget _buttonVoucher() => Container(
        child: RaisedButton.icon(
          onPressed: () {
            print('Button Clicked.');
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          label: Text(
            'Button With Left Icon',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
          textColor: Colors.white,
          splashColor: Colors.red,
          color: Colors.lightBlue,
        ),
      );

  Widget _stackProperty() => Container(
        constraints: BoxConstraints.expand(height: 160),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                color: Color(0xFF8BC34A),
                boxShadow: [new BoxShadow(blurRadius: 3.0)],
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(19.0)),
              ),
            ),
            banner.Banner(),
          ],
        ),
      );
}