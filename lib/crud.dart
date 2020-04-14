
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

  Future<void> addData(item,id) async{
    if(true){
      Firestore.instance.collection('Item').document(id).setData(item).catchError((e){
        print(e);
      });
      Firestore.instance.collection('Retailer').add({'name':"",'shop_name':"",'shop_url':""}).catchError((e){
        print(e);
      });
    }
    else{
      print('you need to be logged in');
    }
  }
  getData() async{
    return await Firestore.instance.collection('Item').getDocuments();
  }

}
