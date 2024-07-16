import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class usermodel{
  final String? id;
  final String name;
  final String email;
  final String password;

  usermodel( {this.id,required this.email, required this.password, required this.name} );

  tojson(){
    return {
      "email" : email,
      "name" : name,
      "password" : password,
    };
  }

}

class userrepository extends GetxController {
  static userrepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createuser(usermodel user) {
    _db.collection("users").doc(user.email).set(user.tojson());
  }
}