import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutterapp/crud.dart';

class items extends StatefulWidget {
  @override
  _itemsState createState() => _itemsState();
}

class _itemsState extends State<items> {
  @override
  crudMethods crudObj = new crudMethods();
  String id,quantity,cost,type,url;
  QuerySnapshot items;

  Widget buildRow(Item,id,url) {
    final String retID = ModalRoute
        .of(context)
        .settings
        .arguments;
    return Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 7,
              child: Image(
                image: NetworkImage(url),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 11,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                        id,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Row(
                    children: <Widget>[
                      Text('quantity : '),
                      Container(
                        width: 100,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: Item.data['quantity'],
                          ),
                          onChanged: (value){
                            this.quantity=value;
                            Map<String,String>ret={
                              'quantity':this.quantity
                            };
                            crudObj.updateData(id, retID,ret).then((result){
                            }).catchError((e){
                              print(e);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('cost : '),
                      Container(
                        width: 100,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: Item.data['cost'],
                          ),
                          onChanged: (value){
                            this.cost=value;
                            Map<String,String>ret={
                              'cost':this.cost
                            };
                            crudObj.updateData(id, retID,ret).then((result){
                            }).catchError((e){
                              print(e);
                            });
                          },
                        ),
                      ),
                      Text('(per '),
                      Text(Item.data['quantity_type'] ),
                      Text(')')
                    ],
                  ),
                ],
              ),
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
            id = item.documentID;
            if(item.data['item_url']==null){
              url='https://chinesenewyear.imgix.net/assets/images/food/chinese-new-year-food-feast.jpg?q=50&w=1920&h=1080&fit=crop&auto=format';
            }
            else{
              url=item.data['item_url'];
            }
            return buildRow(item,id,url);
          });
    }
    else {
      print('loading');
    }
  }


  @override
  Widget build(BuildContext context) {
    final String retID = ModalRoute
        .of(context)
        .settings
        .arguments;
    crudObj.getRetailerItems(retID).then((results) {
      if (results == null) {
        print('no data');
      }
      setState(() {
        items = results;
      });
    });
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('ITEMS')),
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
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: Icon(Icons.add),
                label: 'new item',
                onTap: () {
                  Navigator.pushNamed(context, '/additems', arguments: retID);
                }),
            SpeedDialChild(
                child: Icon(Icons.send),
                label: 'Submit',
                onTap: () {
                  Navigator.pushNamed(context, '/');
                })
          ],
        )
    );
  }
}
