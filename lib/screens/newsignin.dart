import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickticket/models/userdetails.dart';
import 'package:quickticket/models/userdetails.dart';
import 'package:quickticket/screens/loding_screen.dart';
import '../models/userdetails.dart';
import 'firebase_options.dart';
import '../main.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flip_card/flip_card.dart';
import 'package:quickticket/screens/homepage.dart';
import 'package:google_sign_in/google_sign_in.dart';

late usermodel ActiveUser = usermodel(
    email: "dhruvgoplani00@gmail.com", password: "12345678", name: "Dhruv");

class newsiginpage extends StatefulWidget {
  const newsiginpage({Key? key}) : super(key: key);

  @override
  State<newsiginpage> createState() => _newsiginpageState();
}

class _newsiginpageState extends State<newsiginpage> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  late TextEditingController _emailid;
  late TextEditingController _password;
  late TextEditingController _name;
  late TextEditingController _passwordlogin;
  late TextEditingController _emailidlogin;

  final userrepo = Get.put(userrepository());
  final userreposit = Get.put(userrepository());

  final auth = FirebaseAuth.instance.currentUser;

  void createuser(usermodel user) async {
    await userrepo.createuser(user);
  }

  final ActionCodeSettings acs = ActionCodeSettings(
    url:
        "https://quickticket-4e36b.firebaseapp.com/__/auth/action?mode=action&oobCode=code4",
    handleCodeInApp: true,
  );

  Future<UserCredential> SignInWithGoogle() async {
    Get.to(const LoadingScreen());
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );
    UserCredential ans = await FirebaseAuth.instance.signInWithCredential(credential);
    Get.back();
    return ans;

  }

  Future<usermodel> getuserdetails(String email) async {
    CollectionReference col = FirebaseFirestore.instance.collection("users");
    final snapshot = await col.doc(email).get();
    final data = snapshot.data() as Map<String, dynamic>;
    usermodel currentuser = usermodel(
        email: data["email"], password: data["password"], name: data["name"]);
    return currentuser;
  }

  Future<void> register(e, p) async {
    Get.to(LoadingScreen());
    try {
      final credentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: e, password: p).then((value) => Get.back());

      Get.snackbar("", "Please login in to your account",
          snackPosition: SnackPosition.TOP,
          titleText: const Text(
            "Registered",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )
      );
      Get.to(const homepage());
    }
    on FirebaseAuthException catch (e) {
      Get.back();
      if (e.code == 'weak password') {
        print('password is too weak');
        Get.snackbar("", "",
            snackPosition: SnackPosition.TOP,
            titleText: const Text(
              "Weak Password",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ));
      } else if (e.code == 'email-already-in-use') {
        print("account with this email already exists");
        Get.snackbar("", "",
            snackPosition: SnackPosition.TOP,
            titleText: const Text(
              "Account with this email already exists",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
        );
        // Get.back();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> login(e, p, n) async {
    try {
      Get.to(const LoadingScreen());
      final credentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: e, password: p).then((value) => Get.back());
      ActiveUser = await getuserdetails(e);
      final name = ActiveUser.name;
      Get.snackbar("", "",
          snackPosition: SnackPosition.TOP,
          titleText: Text(
            "Welcome $name",
            style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ));
      Get.to(() => const homepage());
    } on FirebaseAuthException catch (e) {
      Get.back();
      if (e.code == 'user-not-found') {
        print("no user found for this email");
      } else if (e.code == 'wrong-passeword') {
        print("you have entered wrong password");
      }
      Get.snackbar("Invalid details entered", "Please enter valid credentials",
          snackPosition: SnackPosition.TOP);
    }
  }

  @override
  void initState() {
    super.initState();
    // parsejsonfile("assets/data.json");
    // storejsoninfirestore("assets/data.json");
    _emailidlogin = TextEditingController();
    _passwordlogin = TextEditingController();
    _name = TextEditingController();
    _emailid = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _passwordlogin.dispose();
    _emailidlogin.dispose();
    _password.dispose();
    _emailid.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
          ),
        ),
        centerTitle: true,
        leading: const Icon(
          Icons.login_outlined,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Image(
                    image: const AssetImage("assets/bus.png"),
                    height: screenheight * 0.1,
                    width: screenwidth * 0.3,
                  ),
                  SizedBox(
                    width: screenwidth * 0.05,
                  ),
                  const Text(
                    "QuickTickets",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenheight * 0.006,
            ),
            Image(
              image: const AssetImage("assets/mainimglogin.png"),
              height: screenheight * 0.15,
              width: screenwidth * 0.9,
            ),
            FlipCard(
              flipOnTouch: false,
              key: cardKey,
              front: Container(
                height: screenheight * 0.485,
                width: screenwidth * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Let\'s go!',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text(
                        "  Full Name",
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: screenheight * 0.006,
                    ),
                    SizedBox(
                      height: screenheight * 0.04,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: TextField(
                          scrollPhysics: const AlwaysScrollableScrollPhysics(),
                          textAlignVertical: TextAlignVertical.center,
                          controller: _name,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: "Enter your name",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenheight * 0.01),
                    const Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text(
                        "  Email",
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: screenheight * 0.006,
                    ),
                    SizedBox(
                      height: screenheight * 0.04,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          scrollPhysics: const AlwaysScrollableScrollPhysics(),
                          textAlignVertical: TextAlignVertical.center,
                          controller: _emailid,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: "Enter your Email",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenheight * 0.01),
                    const Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text(
                        "  Password",
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: screenheight * 0.006,
                    ),
                    SizedBox(
                      height: screenheight * 0.04,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: TextField(
                          scrollPhysics: const AlwaysScrollableScrollPhysics(),
                          obscureText: true,
                          textAlignVertical: TextAlignVertical.center,
                          controller: _password,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: "Enter Password",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenheight * 0.01),
                    Center(
                      child: SizedBox(
                        height: screenheight * 0.05,
                        width: screenwidth * 0.7,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 4.0,
                              backgroundColor: const Color(0xffF9872D),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          onPressed: () {
                            register(_emailid.text, _password.text);
                            final User = usermodel(
                                email: _emailid.text,
                                password: _password.text,
                                name: _name.text,
                                id: auth?.uid);
                            createuser(User);
                          },
                          child: const Center(
                            child: Text(
                              "Register",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      indent: screenwidth * 0.04,
                      endIndent: screenwidth * 0.04,
                    ),
                    GestureDetector(
                      onTap: (){
                      final usermodel = SignInWithGoogle().then((value) => Get.to(const homepage()));
                    },
                      child: Center(
                        child: Container(
                          height: screenheight * 0.05,
                          width: screenwidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(width: 0.5, color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image:
                                    const AssetImage("assets/googleicon.png"),
                                height: screenheight * 0.04,
                              ),
                              SizedBox(
                                width: screenwidth * 0.04,
                              ),
                              const Text(
                                "Sign Up with Google",
                                style: TextStyle(fontSize: 18.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () {
                            cardKey.currentState!.toggleCard();
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15.0,
                            ),
                          )),
                    )
                  ],
                ),
              ),
              back: Container(
                height: screenheight * 0.485,
                width: screenwidth * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Welcome !!',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text(
                        "  Email",
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: screenheight * 0.006,
                    ),
                    SizedBox(
                      height: screenheight * 0.04,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          scrollPhysics: const AlwaysScrollableScrollPhysics(),
                          textAlignVertical: TextAlignVertical.center,
                          controller: _emailidlogin,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: "Enter your email",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenheight * 0.03,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text(
                        "  Password",
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: screenheight * 0.006,
                    ),
                    SizedBox(
                      height: screenheight * 0.04,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: TextField(
                          scrollPhysics: const AlwaysScrollableScrollPhysics(),
                          obscureText: true,
                          textAlignVertical: TextAlignVertical.center,
                          controller: _passwordlogin,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: "Enter Password",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: screenwidth * 0.4, bottom: 0.0),
                      child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.blue),
                            // textAlign: TextAlign.right,
                          )),
                    ),
                    Center(
                      child: SizedBox(
                        height: screenheight * 0.05,
                        width: screenwidth * 0.7,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 4.0,
                              backgroundColor: const Color(0xffF9872D),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0))),
                          onPressed: () {
                            login(_emailidlogin.text, _passwordlogin.text,
                                _name.text);
                          },
                          child: const Center(
                            child: Text(
                              "Log In",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      indent: screenwidth * 0.04,
                      endIndent: screenwidth * 0.04,
                    ),
                    GestureDetector(
                      child: Center(
                        child: GestureDetector(
                          onTap: (){
                            final user = SignInWithGoogle().then((value) => Get.to(const homepage()));
                          },
                          child: Container(
                            height: screenheight * 0.05,
                            width: screenwidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(width: 0.5, color: Colors.grey),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image:
                                      const AssetImage("assets/googleicon.png"),
                                  height: screenheight * 0.04,
                                ),
                                SizedBox(
                                  width: screenwidth * 0.04,
                                ),
                                const Text(
                                  "Login with Google",
                                  style: TextStyle(fontSize: 18.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () {
                            cardKey.currentState!.toggleCard();
                          },
                          child: const Text(
                            "Create a new account",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15.0,
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
