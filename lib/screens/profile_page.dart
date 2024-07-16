import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quickticket/models/userdetails.dart';
import 'package:quickticket/screens/newsignin.dart';
import 'firebase_options.dart';
import 'homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:convert';

class profilepage extends StatefulWidget {
  const profilepage({Key? key}) : super(key: key);

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
          height: screenheight * 0.3,
          decoration: BoxDecoration(
            // color: Colors.teal[900],
            borderRadius: BorderRadius.circular(30)
          ),
        ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenheight * 0.06,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white30
                ),
                height: screenheight * 0.07,
                width: screenwidth,
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                      Get.to(()=>const homepage());
                    }, icon: const Icon(Icons.arrow_back)),
                    const Center(
                      child: Text("User Profile",
                      style: TextStyle(
                            fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenheight * 0.065,
              ),
              const CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                    "https://static.foxnews.com/foxnews.com/content/uploads/2023/04/lebron-game-6.jpg"),
              ),
              SizedBox(
                height: screenheight * 0.03,
              ),
              Text(ActiveUser.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: Colors.black
              ),
              ),
              SizedBox(
                height: screenheight * 0.03,
              ),
              Padding(
                padding:  EdgeInsets.only(right: screenwidth * 0.55,bottom: 8.0),
                child: const Text(
                  "Username",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700
                ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white38,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0
                  )
                ),
                width: screenwidth * 0.8,
                height: screenheight * 0.06,
                child:  Padding(
                  padding:  const EdgeInsets.only(top: 12.0,left: 12.0),
                  child: Text(ActiveUser.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400
                  ),
                  ),
                ),
              ),
              SizedBox(height: screenheight * 0.02,),
              Padding(
                padding:  EdgeInsets.only(right: screenwidth * 0.57,bottom: 8.0),
                child: const Text(
                  "Email I'D",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white38,
                    border: Border.all(
                        color: Colors.white,
                        width: 1.0
                    )
                ),
                width: screenwidth * 0.8,
                height: screenheight * 0.06,
                child: Padding(
                  padding:  const EdgeInsets.only(top: 12.0,left: 12.0),
                  child: Text(ActiveUser.email,
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenheight * 0.02,
              ),
              Padding(
                padding:  EdgeInsets.only(right: screenwidth * 0.45,bottom: 8.0),
                child: const Text(
                  "Phone number",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white38,
                    border: Border.all(
                        color: Colors.white,
                        width: 1.0
                    )
                ),
                width: screenwidth * 0.8,
                height: screenheight * 0.06,
                child: const Padding(
                  padding:  EdgeInsets.only(top: 12.0,left: 12.0),
                  child: Text(
                    "+91-8238936270",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenheight * 0.05,
              ),
              GestureDetector(
                onTap: (){
                  auth.signOut().whenComplete(() => Get.snackbar("LogOut Completed", "",
                  snackPosition: SnackPosition.TOP,
                  ));
                  Get.to(() => const newsiginpage());
                },
                child: Container(
                  height: screenheight * 0.05,
                  width: screenwidth * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: const Color(0xff171F1D)
                  ),
                  child: const Center(
                    child: Text("Sign Out",
                    style: TextStyle(
                      color: Colors.white
                    ),
                    ),
                  ),
                ),
              )
            ],
          )
        ]
      ),
    );
  }
}
