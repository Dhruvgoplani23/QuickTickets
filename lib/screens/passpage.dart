import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'paymentscreen.dart';

class passpage extends StatefulWidget {
  const passpage({Key? key}) : super(key: key);

  @override
  State<passpage> createState() => _passpageState();
}

class _passpageState extends State<passpage> {

  // void payment() async {
  //   String paymenturl = 'upi://pay?pa=dhruvgoplani00@oksbi&pn=DhruvGoplani&am=40.0&tn=PMPMLdailypass&cu=INR';
  //   Uri url = Uri.parse(paymenturl);
  //   if(await canLaunchUrl(url)){
  //     await launchUrl(url);
  //   }
  //   else{
  //     print("payment failed");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Buy Pass",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24.0, color: Colors.black),
        ),
        backgroundColor: Colors.white38,
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: screenwidth * 0.1),
                  child: Image(
                    image: const AssetImage("assets/img.png"),
                    width: screenwidth * 0.8,
                    // height: screenheight * 0.2,
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
            Column(
              children: [
                SizedBox(
                  height: screenheight * 0.3,
                ),
                Center(
                  child: Container(
                    height: screenheight * 0.45,
                    width: screenwidth * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenheight * 0.025,
                        ),
                        const Text(
                          "Pass",
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const Text(
                          "Registration",
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: screenheight * 0.03,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "This pass allows you to travel from any place in pune to any other place in pune for 24 hours",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        SizedBox(
                          height: screenheight * 0.03,
                        ),
                        const Text(
                          "Cost : 40 Rupees Per Person",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: screenheight * 0.035,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(()=>const payment());
                          },
                          child: Container(
                            height: screenheight * 0.05,
                            width: screenwidth * 0.6,
                            decoration: BoxDecoration(
                                color: const Color(0xffF88529),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: const Center(
                              child: Text(
                                "Issue Pass",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
