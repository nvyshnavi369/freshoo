import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'shops.dart';

class additems extends StatefulWidget {
  @override
  _additemsState createState() => _additemsState();
}

class _additemsState extends State<additems> {
  @override
  List<Item>items = [
    Item(name: 'Apple',
        quantity: '10',
        imageUrl: 'images/chinese-new-year-food-feast.jpg'),
    Item(name: 'Banana',
        quantity: '10',
        imageUrl: 'images/chinese-new-year-food-feast.jpg'),
    Item(name: 'Apple',
        quantity: '10',
        imageUrl: 'images/chinese-new-year-food-feast.jpg')
  ];
  createAlertDialog(BuildContext context){
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        content: Column(
          children: <Widget>[
            Row(
            children: <Widget>[
              Text('Name :'),
              Container(
                width:150,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'item name',
                  ),
                ),
              )
            ],
            ),
            Row(
              children: <Widget>[
                Text('Url :'),
                Container(
                  width:150,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'paste url',
                    ),
                  ),
                )
              ],
            ),
            RaisedButton(
              child: Text('Submit'),
              onPressed: (){
                Navigator.pushNamed(context,'/items');},
            )
          ],
        )
      );
    });
  }
  Widget grid() {
    return OrientationBuilder(builder: (context,orientation){
      return GridView.count(crossAxisCount: orientation==Orientation.portrait?2:3,
        crossAxisSpacing: 20,
        children:
          List.generate(items.length, (index){
            return Column(
              children: <Widget>[
                SizedBox(height: 20),
                Image(image: AssetImage(items[index].imageUrl)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(items[index].name),
                    IconButton(
                      icon: Icon(Icons.check),
                      onPressed: (){},
                    )
                  ],
                )
              ],
            );
          }),
      );
    });
  }


  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Center(child: Text('NEW')),
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
        child: grid(),
      ),
      floatingActionButton:SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              child:Icon(Icons.add),
              label:'other item',
              onTap: (){
                createAlertDialog(context);
              }
          ),
          SpeedDialChild(
              child:Icon(Icons.send),
              label:'Submit',
              onTap: (){
                Navigator.pushNamed(context,'/items');}
          )
        ],
      )
    );
  }
}
