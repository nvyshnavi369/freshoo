import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterapp/crud.dart';

class history extends StatefulWidget {
  @override
  _historyState createState() => _historyState();
}

class _historyState extends State<history> {
  crudMethods crudObj = new crudMethods();
  QuerySnapshot items;

  Widget buildRow(Item) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex:5,
              child: CircleAvatar(
                child: Text(Item.data['shopName'][0]),
              )
          ),
          SizedBox(width: 10),
          Expanded(
              flex: 13,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(Item.data['shopName'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        )
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(Item.data['name']),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(Item.data['quantity']),
                          Text(Item.data['quantity_type'])
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('cost : '),
                      Text(Item.data['price'])
                    ],
                  ),
                  SizedBox(height: 5),
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
            return buildRow(item);
          });
    }
    else {
      print('loading');
    }
  }

  @override
  Widget build(BuildContext context) {
    final String custID = ModalRoute
        .of(context)
        .settings
        .arguments;
    crudObj.getHistory(custID).then((results) {
      if (results == null) {
        print('no data');
      }
      setState(() {
        items = results;
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('History')),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Container(
              width: 100,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, size: 20),
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
      floatingActionButton: FloatingActionButton(
        child: Text('Home'),
        onPressed: (){
          Navigator.pushNamed(context, '/');
        },
      ),
    );
  }
}
