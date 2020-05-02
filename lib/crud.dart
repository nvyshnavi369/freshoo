
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class crudMethods{
  bool isLoggedIn(){
    if(FirebaseAuth.instance.currentUser()!=null){
      return true;
    }
    else{
      return false;
    }
  }

  Future<void> addData(item,id,retId,ret) async{
    if(isLoggedIn()){
      Firestore.instance.collection('Item').document(id).setData(item).catchError((e){
        print(e);
      });
      Firestore.instance.collection('Retailer').document(retId).collection('items').document(id).setData(ret).catchError((e){
        print(e);
      });
    }
    else{
      print('you need to be logged in');
    }
  }

  Future<void>addItem(id,retId,ret) async{
    Firestore.instance.collection('Retailer').document(retId).collection('items').document(id).setData(ret).catchError((e){
      print(e);
    });
  }



  Future<void>addHistory(id,data) async{
    for(var i=0;i<data.length;i=i+1) {
      Firestore.instance.collection('History').document(id).collection('items').add(data[i])
          .catchError((e) {
        print(e);
      });
    }
  }
  getHistory(id) async{
    return await Firestore.instance.collection('History').document(id).collection('items').getDocuments();
  }


  emptyCart(id,data) async{
    for(var i=0;i<data.length;i=i+1) {
      return await Firestore.instance.collection('Customer').document(id)
          .collection('cart').getDocuments().then((snapshot){
            for(DocumentSnapshot ds in snapshot.documents){
              ds.reference.delete();
            }
      }).catchError((e) {
        print(e);
      });
    }
  }

  getCart(id) async{
    return await Firestore.instance.collection('Customer').document(id).collection('cart').getDocuments();
  }

  getRetailerItems(id) async{
    return await Firestore.instance.collection('Retailer').document(id).collection('items').getDocuments();
  }
  getRetailer(id) async{
    return await Firestore.instance.collection('Retailer').document(id).get();
  }
  getTransactions(id) async{
    return await Firestore.instance.collection('Transaction').where('retailer_id',isEqualTo:id).getDocuments();
  }
  getNewItems(id) async{
    List out=[];
    var a=[];
    QuerySnapshot Ritems;
    await Firestore.instance.collection('Retailer').document(id).collection('items').getDocuments().then((results) {
      if (results == null) {
        print('nodata');
      }
      else {
        Ritems = results;
        for (int i = 0; i < Ritems.documents.length; i = i + 1) {
          a.add(Ritems.documents[i].documentID);
        }
      }
    });

    var b=[];
    QuerySnapshot items;
    await Firestore.instance.collection('Item').getDocuments().then((results){
      if(results==null){
        print('nodata');
      }
      else{
        items=results;
        for(int i=0;i<items.documents.length;i=i+1){
          b.add(items.documents[i].documentID);
        }
      }
    });
    for(int i=0;i<b.length;i=i+1){
      if(a.contains(b[i])){
        continue;
      }
      else{
        await Firestore.instance.collection('Item').document(b[i]).get().then((result){
          if(result==null){
            print('null');
          }
          else{
            out.add(result);
          }
        });
      }
    }
    return out;

  }


  Future<void>updateData(id,retId,ret) async{
    Firestore.instance.collection('Retailer').document(retId).collection('items').document(id).updateData(ret).catchError((e){
       print(e);
     });
  }

  Future<void>updateShop(shopid,a) async{
    for(var i=0;i<a.length;i=i+1) {
      Firestore.instance.collection('shop').document(shopid).collection('item1')
          .where('item_name', isEqualTo: a[i]['name']).getDocuments()
          .then((result) {
        result.documents.forEach((result) {
          var z=double.parse(result.data['item_quantity']);
          z=z-double.parse(a[i]['quantity']);
          result.reference.setData({'item_quantity':z.toString()},merge: true);
        });
      });
    }
  }

}
