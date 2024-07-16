import 'package:flutter/material.dart';

class aboutuspage extends StatelessWidget {
  const aboutuspage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About Us",
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
          Center(
            child: Container(
              height: screenheight * 0.65,
              width: screenwidth * 0.85,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                children: [
                  SizedBox(
                    height: screenheight * 0.02,
                  ),
                  const Text(
                    "Our Mission",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: screenheight * 0.03,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        "Welcome to Quick-Ticket, app for convenient and hassle-free bus ticketing experience. We are a team of dedicated professionals committed to promoting digitalization and ease of service in the transportation industry. Our app was founded in 2023 with a mission to provide commuters with a seamless way to book and purchase tickets for local public buses of PMC. With our simple and user-friendly interface, you can easily search for available routes, select your preferred seats, and pay securely using your preferred payment method.",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black
                    ),
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
