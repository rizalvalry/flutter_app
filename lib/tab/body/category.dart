import 'package:flutter/material.dart';
import 'package:flutter_app/model/api.dart';
import 'package:flutter_app/tab/body/all_product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Category extends StatelessWidget {
  final String apiUrl = BaseUrl.product;

  Future<List<dynamic>> fetchUsers() async {
    var result = await http.get(apiUrl);
    return json.decode(result.body)['products'];
  }

  String _categories(dynamic user) {
    return user['categories'][0]['name'][0]['name'];
  }

  String _location(dynamic user) {
    return user['name'][0]['languageName'];
  }

  String _price(Map<dynamic, dynamic> user) {
    return "Price: " + user['price'][0]['price'].toString();
  }

  final _voucherImage = {
    {
      'name': 'Bantimurung',
      'image': 'assets/images/bantimurung.jpg',
      'cat': 'Air Terjun',
      'open': '09.00-17.00 WITA'
    },
    {
      'name': 'Pantai Bira',
      'image': 'assets/images/bira.jpg',
      'cat': 'Wisata Bahari',
      'open': '06.00-21.00 WITA'
    },
    {
      'name': 'Malino',
      'image': 'assets/images/malino.jpg',
      'cat': 'Wisata Alam',
      'open': '09.00-17.00 WITA'
    },
    {
      'name': 'Pantai Losari',
      'image': 'assets/images/pantai-losari.jpg',
      'cat': 'Landmark',
      'open': '06.00-17.00 WITA'
    },
    {
      'name': 'Tana Toraja',
      'image': 'assets/images/toraja.jpg',
      'cat': 'Wisata Budaya',
      'open': '9.00-17.00 WITA'
    },
  }.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Expanded(
                      child: ListView.separated(
                        physics: PageScrollPhysics(),
                        separatorBuilder: (context, index) => Divider(
                          indent: 3,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: _voucherImage.length,
                        itemBuilder: (context, index) => voucherBrand(index),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Kategori',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(
                    child: Expanded(
                      child: FutureBuilder<List<dynamic>>(
                        future: fetchUsers(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return favoriteCategory(context, snapshot);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          'Product',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: InkWell(
                                                  child: Text(
                            'Lihat Semua',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
                          ),
                          onTap: () {
                            Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) =>
                                AllProduct()));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget favoriteCategory(BuildContext context, AsyncSnapshot snapshot) {
    return new ListView.separated(
      physics: PageScrollPhysics(),
      separatorBuilder: (context, index) => Divider(
        indent: 3,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                      snapshot.data[index]['files'][0]['thumb'],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _categories(snapshot.data[index]),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
              new Divider(
                height: 2.0,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget voucherBrand(index) {
    return SizedBox(
      height: 30,
      width: 180,
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFF8BC34A),
          border: Border.all(
            width: 1.5,
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.confirmation_number,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _voucherImage[index]['name'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    _voucherImage[index]['cat'],
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  Text(
                    _voucherImage[index]['open'],
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  Text(
                    "Voucher",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
