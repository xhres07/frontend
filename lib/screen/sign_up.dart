import 'dart:async';
import 'package:aqua_store/model/login_model.dart';
import 'package:aqua_store/screen/homepage.dart';
import 'package:aqua_store/screen/login_screen.dart';
import 'package:aqua_store/services/signup_apiservices.dart';
import 'package:aqua_store/utils/shared_preference.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:shake/shake.dart';
import 'package:flutter/foundation.dart' as foundation;
import '../admin/admin_home.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int _currentIndex = 0;
  bool _isNear = false;

  late StreamSubscription<dynamic> _streamSubscription;
  bool apiCallProcess = false;
  bool hidePassword = true;
  bool rehidePassword = true;
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    listenSensor();

    // Shake Sensor

    ShakeDetector.autoStart(onPhoneShake: () {
      MaterialPageRoute(builder: (context) => LoginScreen());
    });

    super.initState();
  }

  Future<void> listenSensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };

    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        _isNear = (event > 0) ? true : false;
      });

      if (_isNear) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _streamSubscription.cancel();
  }

  var confirmPass;

  SizedBox _gap() {
    return const SizedBox(
      height: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 0, 0, 0),
            ])),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              child: Form(
                key: globalFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 170,
                            child: Image.asset(
                              "assets/logo.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    _gap(),
                    _gap(),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Please provide full name";
                        } else {
                          null;
                        }
                      },
                      controller: name,
                      decoration: const InputDecoration(
                        labelText: "Full Name ",
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          color: Color.fromARGB(255, 221, 10, 10),
                        ),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Email is empty";
                        } else {
                          null;
                        }
                      },
                      controller: email,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Color.fromARGB(255, 221, 10, 10),
                        ),
                      ),
                    ),
                    _gap(),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: password,
                      keyboardType: TextInputType.text,
                      validator: (input) {
                        confirmPass = input;
                        if (input == null || input.isEmpty) {
                          return "Password is required";
                        } else {
                          null;
                        }
                      },
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        labelText: "Password ",
                        labelStyle: const TextStyle(color: Colors.white),
                        hintStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Color.fromARGB(255, 221, 10, 10),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                    _gap(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 221, 10, 10),
                          shape: const StadiumBorder(),
                          fixedSize:
                              const Size(double.maxFinite, double.infinity),
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (validateAndSave()) {
                            setState(() {
                              apiCallProcess = true;
                            });
                          }
                          signUpCustomer(
                            name.text,
                            email.text,
                            password.text,
                          ).then((value) => {
                                setState(() {
                                  apiCallProcess = false;
                                }),
                                if (value.isAdmin == false)
                                  {
                                    Fluttertoast.showToast(
                                      msg:
                                          "Congratulations ! \n ${value.name} User has been created.\n",
                                      toastLength: Toast.LENGTH_SHORT,
                                      fontSize: 20.0,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      backgroundColor: Colors.redAccent[700],
                                    ),
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                    ),
                                  }
                                else if (value.message ==
                                    "User validation failed: name: Path `name` is required., email: Path `email` is required.")
                                  {
                                    Fluttertoast.showToast(
                                      msg:
                                          "Error ! \nPlease make sure every thing is correct.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      fontSize: 20.0,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      backgroundColor: Colors.red[800],
                                    )
                                  }
                                else if (value.message == "User already Exists")
                                  {
                                    Fluttertoast.showToast(
                                      msg: "Error ! \nUser already Exists",
                                      toastLength: Toast.LENGTH_SHORT,
                                      fontSize: 20.0,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      backgroundColor: Colors.red[800],
                                    )
                                  }
                              });
                        },
                        child: apiCallProcess == true
                            ? const CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              )
                            : const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0,
                                ),
                              ),
                      ),
                    ),
                    _gap(),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 13,
                        ),
                        children: [
                          const TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(fontSize: 13),
                          ),
                          TextSpan(
                            text: "Login",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 221, 10, 10),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
