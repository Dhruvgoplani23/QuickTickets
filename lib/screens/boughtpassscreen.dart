import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickticket/models/userdetails.dart';
import 'firebase_options.dart';
import '../main.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flip_card/flip_card.dart';
import 'package:quickticket/screens/homepage.dart';
// import 'package:upi_pay/upi_pay.dart';
import 'package:intl/intl.dart';


class boughtpass extends StatelessWidget {
  const boughtpass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "P M P M L Daily Pass",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24.0, color: Colors.black),
        ),
        backgroundColor: Colors.white38,
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: screenwidth * 0.1),
                child: Image(
                  image: const AssetImage("assets/img.png"),
                  width: screenwidth * 0.8,
                ),
              ),
              SizedBox(
                height: screenheight * 0.2,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenwidth * 0.66,
                  ),
                  Image(
                    image: const AssetImage("assets/rotated.png"),
                    height: screenheight * 0.3,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(),
          Center(
            child: Container(
              height: screenheight * 0.4,
              width: screenwidth * 0.75,
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(15.0)
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: screenheight * 0.05,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Text("Name :  ",
                          style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                      Text(name,
                        style: const TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screenheight * 0.02,),
                  const Text("P M P M L",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400
                  ),
                  ),
                  SizedBox(height: screenheight * 0.01,),
                  const Text("P M C Area",
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(
                    height: screenheight * 0.02,
                  ),
                  const Text("Amount - 40 Rupees",
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                  SizedBox(height: screenheight * 0.02,),
                  // Text(DateFormat("d MMM yyyy, EE").format(DateTime.now()),
                  //   style: const TextStyle(
                  //       fontSize: 22.0,
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.w400
                  //   ),
                  // ),
                  SizedBox(height: screenheight * 0.02,),
                  const Text("* Valid upto 23:59:59",
                  style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400
                  ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
