import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutterapp/crud.dart';


class additems extends StatefulWidget {
  @override
  _additemsState createState() => _additemsState();
}

class _additemsState extends State<additems> {
  String name,url,quantity,type,category,cost;
  crudMethods crudObj=new crudMethods();
  List items;
  DocumentSnapshot retailer;
  String retId,urll;
  int selectedRadio;
  String retName;
  @override
  Future<bool>dialogTrigger(BuildContext context)async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder:(BuildContext context){
        return AlertDialog(
          title: Text('job done'),
          content: Text('added'),
          actions: <Widget>[
            FlatButton(
              child: Text('alright'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  createAlertDialog(BuildContext context) {
    final String retID = ModalRoute
        .of(context)
        .settings
        .arguments;

    if (retailer != null) {
      return showDialog(context: context, builder: (context) {
        return Container(
          child: AlertDialog(
              content: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Name :'),
                      Container(
                        width: 150,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'item name',
                          ),
                          onChanged: (value) {
                            this.name = value;
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Url :'),
                      Container(
                        width: 150,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'paste url',
                          ),
                          onChanged: (value) {
                            this.url = value;
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('quantity :'),
                      Container(
                        width: 150,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'quantity',
                          ),
                          onChanged: (value) {
                            this.quantity = value;
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('cost :'),
                      Container(
                        width: 150,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'per unit',
                          ),
                          onChanged: (value) {
                            this.cost = value;
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      PopupMenuButton(
                        child: Text('Type',style: TextStyle(color: Colors.blue),
                        ),
                        itemBuilder: (_) => [
                          PopupMenuItem(child: Text('kg'), value: 'kg',),
                          PopupMenuItem(child: Text('litre'), value: 'litre'),
                          PopupMenuItem(child: Text('unit'), value: 'unit'),
                        ],
                        onSelected: (value) => type=value,
                      ),
                      PopupMenuButton(
                        child: Text('Category',style: TextStyle(color: Colors.blue),
                         ),
                        itemBuilder: (_) => [
                          PopupMenuItem(child: Text('fruites'), value: 'fruits',),
                          PopupMenuItem(child: Text('vegitables'), value: 'vegitables'),
                        ],
                        onSelected: (value) => category=value,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    child: Text('Submit'),
                    onPressed: () {
                      if (name != null) {
                        Navigator.of(context).pop();
                        Map<String, String> itemData = {
                          'category': this.category,
                          'item_url': this.url,
                          'quantity_type': this.type
                        };


                        Map<String, String>retItem = {
                          'item_url': this.url,
                          'quantity': this.quantity,
                          'quantity_type': this.type,
                          'retailer_id': retID,
                          'retailer_name': retailer.data['name'],
                          'cost':this.cost,
                          'item_name':this.name
                        };
                        crudObj.addData(itemData, this.name, retID, retItem).
                        then((result) {
                          dialogTrigger(context);
                        }).
                        catchError((e) {
                          print(e);
                        });
                      }
                      Navigator.pushNamed(context, '/items',arguments: retID);
                    },
                  )
                ],
              )
          ),
        );
      });
    }
    else {
      print('loading');
    }
  }
  Widget grid() {
    final String retID = ModalRoute
        .of(context)
        .settings
        .arguments;
    crudObj.getRetailer(retID).then((results) {
      if (results == null) {
        print('no data');
      }
      setState(() {
        retailer = results;
      });
    });
    if(retailer!=null){
    if (items != null) {

      return OrientationBuilder(builder: (context, orientation) {
        return GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
          crossAxisSpacing: 20,
          children:
          List.generate(items.length, (index) {
            if(items[index].data['item_url']==null){
              urll='https://chinesenewyear.imgix.net/assets/images/food/chinese-new-year-food-feast.jpg?q=50&w=1920&h=1080&fit=crop&auto=format';
            }
            else{
              urll=items[index].data['item_url'];
            }
            return Column(
              children: <Widget>[
                SizedBox(height: 20),
                Expanded(
                  flex: 14,
                    child: Image(image: NetworkImage(urll))
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(items[index].documentID),
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          Map<String, String>retItem = {
                            'quantity': "0",
                            'quantity_type':items[index].data['quantity_type'],
                            'retailer_id': retID,
                            'retailer_name': retailer.data['name'],
                            'cost':'0',
                            'item_url':items[index].data['item_url'],
                            'item_name':items[index].documentID
                          };
                          crudObj.addItem(items[index].documentID , retID, retItem).
                          then((result) {
                            dialogTrigger(context);
                          }).
                          catchError((e) {
                            print(e);
                          });
                        },
                      )
                    ],
                  ),
                )
              ],
            );
          }),
        );
      });
    }
    else{
      print('loading');
    }
  }
    else {
      print('loading');
    }
  }


  Widget build(BuildContext context) {
    final String retID = ModalRoute.of(context).settings.arguments;
    crudObj.getNewItems(retID).then((results){
      if(results==null){print('no data');}
      setState(() {
        items=results;
      });
    });
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
                Navigator.pushNamed(context,'/items',arguments: retID);}
          )
        ],
      )
    );
  }
}
