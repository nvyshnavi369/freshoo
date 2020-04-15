import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutterapp/crud.dart';
import 'main.dart';

class items extends StatefulWidget {
  @override
  _itemsState createState() => _itemsState();
}

class _itemsState extends State<items> {
  @override
  crudMethods crudObj=new crudMethods();
  customer cust=new customer();
  String id;
  int selectedRadio;
  QuerySnapshot items;
  @override
  void initState(){
    selectedRadio=0;
    crudObj.getRetailerItems().then((results){
      if(results==null){print('no data');}
      setState(() {
        items=results;
      });
    });
    super.initState();
  }
  setSelectedRadio(int val){
    setState(() {
      selectedRadio=val;
    });
  }


    Widget buildRow(Item) {
      return Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 7,
              child: Image(
                image: AssetImage( 'images/chinese-new-year-food-feast.jpg'),
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
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: selectedRadio,
                          activeColor: Colors.blue,
                          onChanged: (val){
                            setSelectedRadio(val);
                          },
                        ),
                        Text('kg'),
                        Radio(
                          value: 2,
                          groupValue: selectedRadio,
                          activeColor: Colors.blue,
                          onChanged: (val){
                            setSelectedRadio(val);
                          },
                        ),
                        Text('Liter')
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
              id=item.documentID;
              return buildRow(item);
            });
      }
      else{
        print('loading');
      }
    }


    @override
    Widget build(BuildContext context) {
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
                    Navigator.pushNamed(context, '/additems');
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
