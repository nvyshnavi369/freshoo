import 'dart:math';

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

  Future<void> addData(item) async{
    if(true){
      Firestore.instance.collection('Item').add(item).catchError((e){
        print(e);
      });
    }
    else{
      print('you need to be logged in');
    }
  }
}
