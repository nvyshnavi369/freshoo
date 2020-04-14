
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
  getRetailerItems() async{
    return await Firestore.instance.collection('Retailer').document('qCvJAHc3th4ZgQzoatQ1').collection('items').getDocuments();
  }
  getRetailer() async{
    return await Firestore.instance.collection('Retailer').getDocuments();
  }
}
