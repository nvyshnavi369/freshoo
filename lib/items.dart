import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'shops.dart';

class items extends StatefulWidget {
  @override
  _itemsState createState() => _itemsState();
}

class _itemsState extends State<items> {
  @override


    List<Item> items = [
      Item(
          name: 'Apple',
          quantity: '10',
          imageUrl: 'images/chinese-new-year-food-feast.jpg'),
      Item(
          name: 'Banana',
          quantity: '10',
          imageUrl: 'images/chinese-new-year-food-feast.jpg'),
      Item(
          name: 'Apple',
          quantity: '10',
          imageUrl: 'images/chinese-new-year-food-feast.jpg')
    ];
  int selectedRadio;
  void initState(){
    super.initState();
    selectedRadio=0;
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
                image: AssetImage(Item.imageUrl),
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
                          Item.name,
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
                              hintText: Item.quantity,
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
      return ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext content, int index) {
            Item item = items[index];
            return buildRow(item);
          });
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
