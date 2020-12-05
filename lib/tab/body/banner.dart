import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Banner extends StatefulWidget {
  Banner({Key key}) : super(key: key);

  @override
  _BannerState createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  Future<List<Beehub>> _getBeehubs() async {
    var data = await http.get(BaseUrl.product);
    var jsonData = json.decode(data.body)['products'];
    List<Beehub> users = [];

    for (var u in jsonData) {
      Beehub user = Beehub(
          u['name'][0]['name'],
          u['createdAt'],
          u['files'][0]['original'],
          u['categories'][0]['name'][0]['name'],
          u['price'][0]['price'],
          u['details']['minPurchase'],
          u['discount'],
          u['details']['weight'],
          u['details']['weightCode'],
          u['status'],
          u['store']['name']);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<dynamic>>(
        future: _getBeehubs(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return newProduct(context, snapshot);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget newProduct(BuildContext context, AsyncSnapshot snapshot) {
    return new ListView.separated(
      physics: PageScrollPhysics(),
      separatorBuilder: (context, index) => Divider(
        indent: 3,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        // var rate = int.parse(_keywords(snapshot.data[index]));
        return Container(
          padding: EdgeInsets.only(left: 10.0),
          margin: EdgeInsets.all(20),
          child: InkWell(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(
                    child: Text(
                      snapshot.data[index].index,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Center(
                    child: Text(
                      snapshot.data[index].created,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ]),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          DetailBanner(snapshot.data[index])));
            },
          ),
          height: 190.0,
          width: MediaQuery.of(context).size.width - 100.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.blue,
              image: DecorationImage(
                image: new NetworkImage(snapshot.data[index].picture),
                fit: BoxFit.fitWidth,
              )),
        );
      },
    );
  }
}

class DetailBanner extends StatelessWidget {
  final Beehub user;
  DetailBanner(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF8BC34A),
          // toolbarHeight: 30,
          elevation: 0,
          titleSpacing: 20,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Container(
            margin: new EdgeInsets.only(bottom: 15.0, top: 15.0),
            child: Text("Produk Detail"),
          ),
          actions: [
            IconButton(icon: Icon(Icons.message), onPressed: () => null),
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
              child: _newStackProperty(context),
            ),
            new Padding(
              padding: EdgeInsets.only(bottom: 20.0),
            ),
            Column(
              children: [
                ListTile(
                  title: Text(user.index,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.green,
                          fontSize: 20.0)),
                  subtitle: Text(user.store),
                ),
                Divider(),
                ListTile(
                    title: Text(
                        "Rp. ${user.price - (user.price * user.disc / 100)}",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    leading: Icon(
                      Icons.announcement,
                      color: Colors.blue[500],
                    ),
                    subtitle: Text("Discount ${user.disc.toString()} %")),
                ListTile(
                  title: Text(
                    "Minimal pembelian ${user.min} Paket",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            new Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Color(0xFF8BC34A),
                child: new Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Padding(
                          padding: new EdgeInsets.all(7.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Padding(
                                padding: new EdgeInsets.all(7.0),
                                child: new Text('Informasi Produk',
                                    style: new TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            ],
                          )),
                      new Padding(
                          padding: new EdgeInsets.all(2.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Padding(
                                padding: new EdgeInsets.all(7.0),
                                child: new Text(
                                  'Berat',
                                  style: new TextStyle(
                                      fontSize: 15.0, color: Colors.white),
                                ),
                              ),
                              new Padding(
                                padding: new EdgeInsets.all(7.0),
                                child: new Text(
                                    "${user.weight.toString()} ${user.weightCode}",
                                    style: new TextStyle(
                                        fontSize: 15.0, color: Colors.white)),
                              )
                            ],
                          )),
                      new Padding(
                          padding: new EdgeInsets.all(2.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Padding(
                                padding: new EdgeInsets.all(7.0),
                                child: new Text(
                                  'Kondisi',
                                  style: new TextStyle(
                                      fontSize: 15.0, color: Colors.white),
                                ),
                              ),
                              new Padding(
                                padding: new EdgeInsets.all(7.0),
                                child: user.status == "active"
                                    ? new Text("Baru",
                                        style: new TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white))
                                    : new Text("Lama",
                                        style: new TextStyle(
                                            fontSize: 15.0, color: Colors.red)),
                              )
                            ],
                          )),
                      new Padding(
                          padding: new EdgeInsets.all(2.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Padding(
                                padding: new EdgeInsets.all(7.0),
                                child: new Text(
                                  'Pesanan Minimal',
                                  style: new TextStyle(
                                      fontSize: 15.0, color: Colors.white),
                                ),
                              ),
                              new Padding(
                                padding: new EdgeInsets.all(7.0),
                                child: new Text(user.min.toString(),
                                    style: new TextStyle(
                                        fontSize: 15.0, color: Colors.white)),
                              )
                            ],
                          )),
                      new Padding(
                          padding: new EdgeInsets.all(2.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Padding(
                                padding: new EdgeInsets.all(7.0),
                                child: new Text(
                                  'Kategori',
                                  style: new TextStyle(
                                      fontSize: 15.0, color: Colors.white),
                                ),
                              ),
                              new Padding(
                                padding: new EdgeInsets.all(7.0),
                                child: new Text(user.categories,
                                    style: new TextStyle(
                                        fontSize: 15.0, color: Colors.yellow)),
                              )
                            ],
                          ))
                    ]))
          ],
        ));
  }

  Widget _newStackProperty(BuildContext context) => Container(
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
            Center(
              child: Container(
                padding: EdgeInsets.only(left: 10.0),
                margin: EdgeInsets.all(20),
                height: 190.0,
                width: MediaQuery.of(context).size.width - 100.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue,
                    image: DecorationImage(
                      image: new NetworkImage(user.picture),
                      fit: BoxFit.fitWidth,
                    )),
              ),
            ),
          ],
        ),
      );
}

class Beehub {
  final String index;
  final String created;
  final String picture;
  final String categories;
  final int price;
  final int min;
  final int disc;
  final dynamic weight;
  final String weightCode;
  final String status;
  final String store;

  Beehub(
      this.index,
      this.created,
      this.picture,
      this.categories,
      this.price,
      this.min,
      this.disc,
      this.weight,
      this.weightCode,
      this.status,
      this.store);
}
