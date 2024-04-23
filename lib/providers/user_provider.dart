import'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:food_app/models/user_model.dart';
class UserProvider with ChangeNotifier{
  late UserModel currentData;

  void addUserData({required User currentUser,required String userName,required String userEmail ,required String userImage, })async{
   await FirebaseFirestore.instance.collection("userData").doc(currentUser.uid).set(
        {
          "userName": userName,
          "userEmail":userEmail,
          "userImage": userImage,
          "userUid":  currentUser.uid,

        },
    );
  }

  void getUserData()async{
    UserModel userModel;
   var value= await FirebaseFirestore.instance.collection("userData").doc(FirebaseAuth.instance.currentUser?.uid)
    .get();
   if(value.exists){
     userModel=UserModel(
         userEmail: value.get("userName"),
         userImage: value.get("userEmail"),
         userName:value.get("userImage"),
         userUid: value.get("userUid"),
     );
     currentData=userModel;
     notifyListeners();
   }
  }
  UserModel get currentUserData{
    return currentData;
  }

}