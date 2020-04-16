import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterapp/crud.dart';
import 'items.dart';
import 'additems.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/':(context) =>customer(),
    '/items':(context) =>items(),
    '/additems':(context) =>additems(),
  },
));
class customer extends StatefulWidget {
  @override
  _customerState createState() => _customerState();
}

class _customerState extends State<customer> {
  String retID="qCvJAHc3th4ZgQzoatQ1";                     //here the id should be sent to
  crudMethods crudObj=new crudMethods();
  QuerySnapshot items;
  String transactionId;
  Widget buildRow(Item) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Image(
              image: AssetImage('images/chinese-new-year-food-feast.jpg'),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
              flex: 11,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(Item.data['store_name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: (){
                        },
                        icon: Icon(Icons.call_made),
                        color: Colors.blue,
                      ),
                      Text(Item.data['item_name']),
                      Text(Item.data['item_quantity']),
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
    if (items != null) {
      return ListView.builder(
          itemCount: items.documents.length,
          itemBuilder: (BuildContext content, int index) {
            DocumentSnapshot item = items.documents[index];
            transactionId=item.documentID;
            return buildRow(item);
          });
    }
    else{
      print('loading');
    }
  }

  @override
   Widget build(BuildContext context) {
    crudObj.getTransactions(retID).then((results){
      if(results==null){print('no data');}
      setState(() {
        items=results;
      });
    });
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('SALES')),
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
            Navigator.pushNamed(context,'/items',arguments: retID);
          },
          label: Text('Items'),
        ) ,
    );
  }
}


