import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickticket/models/routes.dart';
import 'package:quickticket/screens/loding_screen.dart';
import 'package:quickticket/screens/paymentscreen.dart';
import 'package:upi_india/upi_india.dart';
import '../main.dart';
import 'package:intl/intl.dart';
import 'homepage.dart';
import 'package:get/get.dart';
import 'package:upi_india/upi_app.dart';

//
// List<BusInfo> Allroutes = [
// BusInfo(ladiesReservation: "Yes", lastBus: "21:30", firstBus: "7:00", frequency: 30, from: "Katraj", to: "Kothrud Depot", busNumber: 103, fare: 25),
// BusInfo(ladiesReservation: "No", lastBus: "21:30", firstBus: "7:00", frequency: 30, from: "Katraj", to: "Kharadi Gaon", busNumber: 235, fare: 30),
// BusInfo(ladiesReservation: "Yes", lastBus: "21:30", firstBus: "7:00", frequency: 30, from: "Katraj", to: "Hadapsar", busNumber: 291, fare: 25),
// BusInfo(ladiesReservation: "Yes", lastBus: "21:40", firstBus: "7:00", frequency: 20, from: "Katraj", to: "Hinjewadi PH3", busNumber: 43, fare: 40),
// BusInfo(ladiesReservation: "No", lastBus: "21:35", firstBus: "7:00", frequency: 25, from: "Swargate", to: "Alandi", busNumber: 29, fare: 45),
// BusInfo(ladiesReservation: "No", lastBus: "21:50", firstBus: "7:00", frequency: 10, from: "Balaji Nagar", to: "Swargate", busNumber: 103, fare: 5),
// BusInfo(ladiesReservation: "Yes", lastBus: "21:50", firstBus: "7:00", frequency: 10, from: "Swargate", to: "Deccan Corner", busNumber: 103, fare: 5),
// BusInfo(ladiesReservation: "No", lastBus: "21:50", firstBus: "7:00", frequency: 10, from: "Deccan Corner", to: "Vanaz", busNumber: 103, fare: 5),
// BusInfo(ladiesReservation: "No", lastBus: "21:50", firstBus: "7:00", frequency: 10, from: "Vanaz", to: "Kothrud Depot", busNumber: 103, fare: 10),
// BusInfo(ladiesReservation: "No", lastBus: "21:50", firstBus: "7:00", frequency: 10, from: "Kate Colony", to: "Alandi", busNumber: 29, fare: 5),
// ];

class busresult extends StatefulWidget {
  busresult({super.key, required this.numberofpassengers,required this.time,required this.date,required this.seniorcitizen,this.sourcedestinantion,this.destination});
  String? sourcedestinantion;
  String? destination;
  DateTime date;
  TimeOfDay time;
  int numberofpassengers;
  bool seniorcitizen;

  @override
  State<busresult> createState() => _busresultState();
}

class _busresultState extends State<busresult> {

  late BusInfo reqroute = BusInfo(ladiesReservation: "", lastBus: "", firstBus: "7:00", frequency: 10, from: "", to: "No Buses Found", busNumber: 0, fare: 0);
  int flag = 0;

  Future<UpiResponse>? _transaction;
  final UpiIndia _upiIndia = UpiIndia();
  late List<UpiApp> apps = [];


  Future<List<UpiApp>> getupiapps() async {
    return _upiIndia.getAllUpiApps(mandatoryTransactionId: false);
  }

  late UpiApp app = UpiApp.googlePay;

  Future<void> getroutes(String s,String d)async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('Routes').doc('${s}to$d').get();
    if(snapshot.exists){
      Map<String,dynamic> x = snapshot.data() as Map<String,dynamic>;
      BusInfo temp = BusInfo(ladiesReservation: x['ladiesReservation'], lastBus: x['lastBus'], firstBus: x['firstBus'], frequency: x['frequency'], from: x['from'], to: x['to'], busNumber: x['busNumber'], fare: x['fare']);
      reqroute.to = temp.to;
      flag = 1;
    }
    else{
      print('no data found');
    }
  }

  Future<UpiResponse> initiate_transaction(UpiApp app) async {
    return _upiIndia.startTransaction(app: app,
      receiverUpiId: 'dhruvgoplani00@oksbi',
      receiverName: 'Dhruv goplani', transactionRefId: "kn",
      amount: (reqroute.fare * widget.numberofpassengers).toDouble(),
      currency: 'INR',
    );
  }

  Widget displayupiapps() {
    return FutureBuilder<List<UpiApp>>(
      future: getupiapps(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display a loading indicator while fetching apps
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<UpiApp> apps = snapshot.data!;
          return Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Wrap(
                children: apps.map<Widget>((UpiApp app) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _transaction = initiate_transaction(app);
                      });
                    },
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.memory(
                            app.icon ?? Uint8List(0),
                            height: 60,
                            width: 60,
                          ),
                          Text(app.name),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        } else {
          return Text('No UPI apps found.');
        }
      },
    );
  }

  //
  // void results(String s,String d){
  //   for(int i = 0;i<10;i++){
  //     if(Allroutes[i].to == d && Allroutes[i].from == s){
  //       reqroute = Allroutes[i];
  //       flag = 1;
  //       break;
  //     }
  //   }
  // }

  TimeOfDay addMinutesToTime(TimeOfDay time, int minutes) {
    final currentTimeInMinutes = time.hour * 60 + time.minute;
    final updatedTimeInMinutes = currentTimeInMinutes + minutes;

    final updatedHour = updatedTimeInMinutes ~/ 60;
    final updatedMinute = updatedTimeInMinutes % 60;

    return TimeOfDay(hour: updatedHour, minute: updatedMinute);
  }

  int compareTimeOfDay(TimeOfDay time1, TimeOfDay time2) {
    if (time1.hour < time2.hour) {
      return -1;
    } else if (time1.hour > time2.hour) {
      return 1;
    } else {
      if (time1.minute < time2.minute) {
        return -1;
      } else if (time1.minute > time2.minute) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  TimeOfDay reqtime(TimeOfDay t,int f){
    TimeOfDay start = const TimeOfDay(hour: 7, minute: 00);
    while(compareTimeOfDay(start, t) == -1){
      start = addMinutesToTime(start, f);
    }
    if(start.hour < 7 || start.hour > 22){
      start = const TimeOfDay(hour: 7, minute: 00);
    }
    return start;
  }

  // @override
  // void initState() {
  //   getroutes(widget.sourcedestinantion.toString(), widget.destination.toString());
  //   // TODO: implement in5itState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    getroutes(widget.sourcedestinantion.toString(), widget.destination.toString());
    // results(widget.sourcedestinantion.toString(), widget.destination.toString());
    final t = reqtime(widget.time, reqroute.frequency);
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("QuickTickets",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26.0),
        ),
        centerTitle: true,
      ),
      body:
      // flag == 0 ?
      // Center(
      //   child: Text(reqroute.to,
      //   style: const TextStyle(
      //     fontSize: 24.0,
      //     color: Colors.white
      //   ),
      //   ),
      // ) :
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Bus Results",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white60,
                  fontWeight: FontWeight.bold
                ),
                ),
              ),
              SizedBox(height: screenheight * 0.07,),
              Center(
                child: GestureDetector(
                  onTap: (){
                    showDialog(context: context, builder: (BuildContext context){
                      return Dialog(
                        child: Container(
                          height: screenheight * 0.45,
                          width: screenwidth * 0.6,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(55.0)
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: screenheight * 0.003,),
                              const Text("PMPML Bus Ticket",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              ),
                              ),
                              SizedBox(height: screenheight * 0.02,),
                              Image(image: const AssetImage("assets/PMPML_logo.jpg"),
                              height: screenheight * 0.1,
                              ),
                              SizedBox(height: screenheight * 0.03,),
                              const Text("Bus Ticket ",
                              style: TextStyle(
                                fontSize:  18.0,
                                fontWeight: FontWeight.w600
                              ),
                              ),
                              SizedBox(height: screenheight * 0.01,),
                              Text("From : ${reqroute.from}",style: const TextStyle(
                                  fontSize:  18.0,
                                  fontWeight: FontWeight.w600
                              ),),
                              SizedBox(height: screenheight * 0.01,),
                              Text("To : ${reqroute.to}",style: const TextStyle(
                                  fontSize:  18.0,
                                  fontWeight: FontWeight.w600
                              ),),
                              SizedBox(height: screenheight * 0.02,),
                              Text("Number of Passengers : ${widget.numberofpassengers}",
                                style: const TextStyle(
                                  fontSize:  18.0,
                                  fontWeight: FontWeight.w600
                              ),),
                              SizedBox(height: screenheight * 0.02,),
                              Text("Total cost : ${reqroute.fare * widget.numberofpassengers} Rs",
                                style: const TextStyle(
                                    fontSize:  18.0,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              SizedBox(height: screenheight * 0.02,),
                              GestureDetector(
                                onTap: ()async{
                                  await displayupiapps();
                                  initiate_transaction(app);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xffFA8B31),
                                    borderRadius: BorderRadius.circular(15.0)
                                  ),
                                  height: screenheight * 0.05,
                                  width: screenwidth * 0.4,
                                  child: const Center(
                                    child: Text("Pay",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold
                                    ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
                  },
                  child: Container(
                    width: screenwidth * 0.75,
                    height: screenheight * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.blueGrey,width: 0.5)
                    ),
                    child: Row(
                      children: [
                        const Image(image: AssetImage("assets/img_2.png")),
                        SizedBox(width: screenwidth * 0.03,),
                        Column(
                          children: [
                            Text("Bus Number : ${reqroute.busNumber}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.black
                            ),
                            ),
                            SizedBox(height: screenheight * 0.007,),
                            Text("Time : ${t.format(context)}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.black
                              ),
                            ),
                            SizedBox(height: screenheight * 0.01,),
                            Text("Cost per person : ${reqroute.fare} Rs",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.black
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ),
                ),
              )
            ],
          )

    );
  }
}
