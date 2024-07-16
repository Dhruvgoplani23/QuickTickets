import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickticket/models/routes.dart';
import 'package:quickticket/models/userdetails.dart';
import 'package:quickticket/screens/aboutus.dart';
import 'package:quickticket/screens/loding_screen.dart';
import 'package:quickticket/screens/newsignin.dart';
import 'package:quickticket/screens/passpage.dart';
import 'package:quickticket/screens/profile_page.dart';
import '../main.dart';
import 'package:intl/intl.dart';
import 'busresults.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

late String name = ActiveUser.name;

List<String> source = [
  "Katraj",
  "Kate Colony",
  "Swargate",
  "Balaji Nagar",
  "Deccan Corner",
  "Vanaz"
];

List<String> destination = [
  "Kothrud Depot",
  "Alandi",
  "Kharadi Gaon",
  "Hadapsar",
  "Hinjewadi PH3",
  "Swargate",
  "Deccan Corner",
  "Vanaz"
];

List<IconData> listOfIcons = [
  Icons.home_rounded,
  FontAwesomeIcons.ticketAlt,
  Icons.person_rounded,
  Icons.info_outline,
];

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  var currentIndex = 0;
  bool isseniorcitizen = false;
  DateTime _dateTime = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  int numberofpassengers = 1;
  final auth = FirebaseAuth.instance;
  final int index = source.length;
  String source_destination = "Katraj";
  String destination_name = "Hadapsar";
  final int dindex = destination.length;

  void ShowSourceDestination(BuildContext context) async {
    // Get.to(()=> const LoadingScreen());
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          // Get.back();
          return Dialog(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0)
              ),
              height: MediaQuery.of(context).size.height * 0.45,
              child: ListView.builder(
                itemCount: index,
                  itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade200
                    )
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.location_on),
                    trailing: const Icon(Icons.radio_button_off_outlined),
                    title: Text(source[index]),
                    onTap: () {
                      setState(() {
                        source_destination = source[index];
                        Get.back();
                      });
                    },
                  ),
                );
              }),
            ),
          );
        });
  }

  void ShowDestination(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0)
              ),
              child: ListView.builder(
                  itemCount: dindex,
                  itemBuilder: (BuildContext context, int dindex) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade200
                        )
                      ),
                      child: ListTile(
                        selectedColor: Colors.blue,
                        leading: const Icon(Icons.location_on),
                        trailing: const Icon(Icons.radio_button_off_outlined),
                        title: Text(destination[dindex]),
                        onTap: () {
                          setState(() {
                            destination_name = destination[dindex];
                            Get.back();
                          });
                        },
                      ),
                    );
                  }),
            ),
          );
        });
  }

  void _showdatepicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 10)),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                      primary: Colors.teal,
                      onPrimary: Colors.white,
                      onSurface: Colors.black)),
              child: child!);
        }).then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }

  Future<void> _showtimepicker() async {
    TimeOfDay? newtime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      time = newtime!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Drawer(
            backgroundColor: Colors.teal.shade300,
            shadowColor: Colors.black,
            width: screenwidth * 0.7,
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(color: Color(0xff6ABCAB)),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: screenwidth * 0.12,
                        backgroundImage: const NetworkImage(
                            "https://static.foxnews.com/foxnews.com/content/uploads/2023/04/lebron-game-6.jpg"),
                      ),
                      Text(
                        name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: ListTile(
                    tileColor: const Color(0xff6ABCAB),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 2.0,
                          color: Colors.teal.shade300,
                        ),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0))),
                    leading: const Icon(
                      Icons.home,
                      size: 30.0,
                    ),
                    title: const Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const passpage());
                  },
                  child: ListTile(
                    tileColor: const Color(0xff6ABCAB),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 2.0,
                          color: Colors.teal.shade300,
                        ),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0))),
                    leading: const Icon(
                      FontAwesomeIcons.ticketAlt,
                      size: 30.0,
                    ),
                    title: const Text(
                      "Pass ",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const profilepage());
                  },
                  child: ListTile(
                    tileColor: const Color(0xff6ABCAB),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 2.0,
                          color: Colors.teal.shade300,
                        ),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0))),
                    leading: const Icon(
                      Icons.person,
                      size: 30.0,
                    ),
                    title: const Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const aboutuspage());
                  },
                  child: ListTile(
                    tileColor: const Color(0xff6ABCAB),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 2.0,
                          color: Colors.teal.shade300,
                        ),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0))),
                    leading: const Icon(
                      Icons.info_outline,
                      size: 30.0,
                    ),
                    title: const Text(
                      "About",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    auth.signOut().whenComplete(() => Get.snackbar(
                          "Logout complete",
                          "",
                          snackPosition: SnackPosition.TOP,
                        ));
                    Get.to(() => const newsiginpage());
                  },
                  child: ListTile(
                    tileColor: const Color(0xff6ABCAB),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 2.0,
                          color: Colors.teal.shade300,
                        ),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0))),
                    leading: const Icon(
                      Icons.logout_outlined,
                      size: 30.0,
                    ),
                    title: const Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
      appBar: AppBar(
        title: const Text(
          "QuickTickets",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26.0),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => const profilepage());
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.person,
                size: 30.0,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenheight * 0.05,
            ),
            Center(
              child: Image(
                image: const AssetImage(
                  "assets/mainimglogin.png",
                ),
                width: screenwidth * 0.7,
              ),
            ),
            SizedBox(
              height: screenheight * 0.1,
            ),
            Container(
              height: screenheight * 0.4,
              width: screenwidth * 0.85,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white,
                    Colors.teal.shade300,
                  ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                  borderRadius: BorderRadius.circular(20.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenheight * 0.03,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Text(
                              "Source station",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: screenheight * 0.015,
                          ),
                          GestureDetector(
                            onTap: () {
                              ShowSourceDestination(context);
                            },
                            child: Column(
                              children: [
                                Text(
                                  source_destination,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                SizedBox(
                                  height: screenheight * 0.01,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 14.0),
                                  child: Text(
                                    "$source_destination stop",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: screenwidth * 0.06,
                      ),
                      const Icon(
                        Icons.compare_arrows,
                        color: Colors.blue,
                      ),
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 14.0),
                            child: Text(
                              "Destination station",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: screenheight * 0.015,
                          ),
                          GestureDetector(
                            onTap: (){
                              ShowDestination(context);
                            },
                            child: Column(
                              children: [
                                Text(
                                  destination_name,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                SizedBox(
                                  height: screenheight * 0.01,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 14.0),
                                  child: Text(
                                    "$destination_name stop",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                    indent: screenwidth * 0.05,
                    endIndent: screenwidth * 0.05,
                    thickness: 0.6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, top: 12.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showdatepicker();
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Date of Journey",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: screenheight * 0.01,
                              ),
                              Text(
                                DateFormat('d MMM yyyy , EE').format(_dateTime),
                                style: const TextStyle(fontSize: 15.0),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: screenwidth * 0.04),
                        Row(
                          children: [
                            const Text(
                              'Senior Citizen ?',
                              style: TextStyle(fontSize: 12.0),
                            ),
                            Switch(
                              value: isseniorcitizen,
                              onChanged: (newstate) {
                                setState(() {
                                  isseniorcitizen = !isseniorcitizen;
                                });
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0, left: 14.0),
                    child: GestureDetector(
                      onTap: () {
                        _showtimepicker();
                      },
                      child: Row(
                        children: [
                          const Text(
                            "Select Time : ",
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            time.format(context),
                            style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 14.0, left: 14.0),
                    child: Text(
                      "Select number of passengers : ",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                numberofpassengers -= 1;
                                if (numberofpassengers <= 0) {
                                  numberofpassengers = 1;
                                  Get.snackbar(
                                    "There Should be atleast one passenger",
                                    "",
                                    snackPosition: SnackPosition.TOP,
                                  );
                                }
                              });
                            },
                            icon: const Icon(Icons.remove_circle_outline)),
                        Text(
                          numberofpassengers.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.black),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                numberofpassengers += 1;
                                if(numberofpassengers > 20){
                                  numberofpassengers = 20;
                                  Get.snackbar("Maximum ticket limit reached", "",);
                                }
                              });
                            },
                            icon: const Icon(Icons.add_circle_outline)),
                        SizedBox(
                          width: screenwidth * 0.15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffFA8B31),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onPressed: () {
                            Get.to(
                              () => busresult(
                                sourcedestinantion: source_destination,
                                destination: destination_name,
                                seniorcitizen: isseniorcitizen,
                                time: time,
                                date: _dateTime,
                                numberofpassengers: numberofpassengers,
                              ),
                            );
                          },
                          child: const Center(
                              child: Text(
                            "Check Buses",
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   margin: const EdgeInsets.all(20),
      //   height: screenwidth * .155,
      //   decoration: BoxDecoration(
      //     color: const Color(0xffFA8B31),
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.black.withOpacity(.15),
      //         blurRadius: 30,
      //         offset: const Offset(0, 10),
      //       ),
      //     ],
      //     borderRadius: BorderRadius.circular(50),
      //   ),
      //   child: ListView.builder(
      //     itemCount: 4,
      //     scrollDirection: Axis.horizontal,
      //     padding: EdgeInsets.symmetric(horizontal: screenwidth * .024),
      //     itemBuilder: (context, index) => InkWell(
      //       onTap: () {
      //         setState(() {
      //           currentIndex = index;
      //           HapticFeedback.lightImpact();
      //         });
      //       },
      //       splashColor: Colors.transparent,
      //       highlightColor: Colors.transparent,
      //       child: Stack(
      //         children: [
      //           SizedBox(
      //             width: screenwidth * .2125,
      //             child: Center(
      //               child: AnimatedContainer(
      //                 duration: const Duration(seconds: 1),
      //                 curve: Curves.fastLinearToSlowEaseIn,
      //                 height: index == currentIndex ? screenwidth * .12 : 0,
      //                 width: index == currentIndex ? screenwidth * .2125 : 0,
      //                 decoration: BoxDecoration(
      //                   color: index == currentIndex
      //                       ? Colors.blueAccent.withOpacity(.2)
      //                       : Colors.transparent,
      //                   borderRadius: BorderRadius.circular(50),
      //                 ),
      //               ),
      //             ),
      //           ),
      //           Container(
      //             width: screenwidth * .2125,
      //             alignment: Alignment.center,
      //             child: Icon(
      //               listOfIcons[index],
      //               size: screenwidth * .076,
      //               color: index == currentIndex
      //                   ? Colors.blueAccent
      //                   : Colors.white,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
