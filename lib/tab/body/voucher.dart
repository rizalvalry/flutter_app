import 'package:flutter/material.dart';

class Voucher extends StatelessWidget {


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
             
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  

  Widget voucherBrand(index) {
    return SizedBox(
      // height: 20,
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
              height: 10,
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
