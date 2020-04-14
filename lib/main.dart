import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'shops.dart';
import 'items.dart';
import 'additems.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/':(context) =>customer(),
    '/items':(context) =>items(),
    '/additems':(contex) =>additems(),
  },
));
class customer extends StatefulWidget {
  @override
  _customerState createState() => _customerState();
}

class _customerState extends State<customer> {
  List<Shop>shops = [
    Shop(name: 'Local Mart',
        imageUrl: 'images/chinese-new-year-food-feast.jpg'),
    Shop(name: 'Daily Needs',
        imageUrl: 'images/chinese-new-year-food-feast.jpg'),
    Shop(name: 'Local Mart',
        imageUrl: 'images/chinese-new-year-food-feast.jpg'),
    Shop(name: 'Daily Needs',
        imageUrl: 'images/chinese-new-year-food-feast.jpg'),
    Shop(name: 'Local Mart',
        imageUrl: 'images/chinese-new-year-food-feast.jpg'),
    Shop(name: 'Daily Needs',
        imageUrl: 'images/chinese-new-year-food-feast.jpg'),
  ];
  createAlertDialog(BuildContext context){
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title:Text('item name'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('item quantity'),
            RaisedButton(
              onPressed: (){
                Navigator.pushNamed(context,'/');
              },
              child: Text('OK'),
            )
          ],
        ),
      );
    });
  }

  Widget buildRow(Shop) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Image(
              image: AssetImage(Shop.imageUrl),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
              flex: 11,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(Shop.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: (){
                          createAlertDialog(context);
                        },
                        icon: Icon(Icons.call_made),
                        color: Colors.blue,
                      ),

                    ],
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }

  Widget list() {
    return ListView.builder(
        itemCount: shops.length,
        itemBuilder: (BuildContext content, int index) {
          Shop shop = shops[index];
          return buildRow(shop);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('REQUESTS')),
          leading:Row(
            children: <Widget>[
              GestureDetector(
                onTap:(){print("dfghj");},
                child: Icon(Icons.menu,size: 30),
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20),
              child:  Container(
                width: 100,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,size: 20),
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          child: list(),
        ),
        floatingActionButton:FloatingActionButton.extended(
          onPressed: (){
            Navigator.pushNamed(context,'/items');
          },
          label: Text('Items'),
        ) ,
    );
  }
}


