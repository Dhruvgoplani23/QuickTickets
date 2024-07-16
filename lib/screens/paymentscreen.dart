import 'package:flutter/material.dart';

class payment extends StatelessWidget {
  const payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
          color: Colors.black
        ),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Image(image: AssetImage("assets/dhruvqr.jpg"),
        // height: ,
        ),
      ),
    );
  }
}
