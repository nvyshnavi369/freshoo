
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
    if(true){
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
    return await Firestore.instance.collection('Item').getDocuments();
  }


  Future<void>updateData(id,retId,ret) async{
    print('yes');
    Firestore.instance.collection('Retailer').document(retId).collection('items').document(id).updateData(ret).catchError((e){
       print(e);
     });
  }
}
