import 'dart:async';
import 'package:cool_alert/cool_alert.dart';
import 'package:TMart/colorFile.dart';
import 'package:TMart/firebaseDatabase.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

int j = 1;
int i = 0;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with ColorFile {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(children: [
                      Expanded(
                        flex: 4,
                        child:
                            Container(child: Image.asset('lib/assets/1.png')),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                'Thapar Market',
                                style: TextStyle(
                                    color: orangeYellow,
                                    fontSize: 37,
                                    fontFamily: 'Maven',
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.3),
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(70)),
                      color: charcoal),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: charcoal,
                  child: Container(
                    child: Column(children: [
                      Expanded(flex: 5, child: BottomContainer()),
                      Expanded(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Made with ❤ by Harmanjit14',
                              style: TextStyle(
                                letterSpacing: 1.3,
                              ),
                            )),
                      ),
                    ]),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(70)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class BottomContainer extends StatefulWidget {
  @override
  _BottomContainerState createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer>
    with ColorFile, FirebaseDatabase {
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  void _doSomethingLogin() async {
    var temp = await loginUser();
    if (temp == null) {
      _btnController.success();
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/2');
      });
    } else {
      Timer(Duration(seconds: 2), () {
        _btnController.error();
        CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: "Oops...",
            text: "Email or Password not correct",
            confirmBtnColor: burntRed);
      });
      print('REGISTRATION FAILED');
      print(temp);
      Timer(Duration(seconds: 4), () {
        _btnController.reset();
      });
    }
  }

  Widget loginButtton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(children: [
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.fromLTRB(0, 0, 20, 25),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      i = 0;
                    });
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 40,
                    color: sandyBrown,
                  ),
                )),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElasticInLeft(
                child: TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    prefixIcon: Icon(
                      Icons.arrow_right,
                      color: sandyBrown,
                      size: 30,
                    ),
                    suffixIcon: Icon(
                      Icons.arrow_left,
                      color: sandyBrown,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElasticInRight(
                child: TextField(
                  obscureText: true,
                  obscuringCharacter: '*',
                  onChanged: (value) {
                    password = value;
                  },
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    prefixIcon: Icon(
                      Icons.arrow_right,
                      color: sandyBrown,
                      size: 30,
                    ),
                    suffixIcon: Icon(
                      Icons.arrow_left,
                      color: sandyBrown,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ]),
          Container(
            child: ZoomIn(
              child: Container(
                height: 100,
                child: Container(
                  child: RoundedLoadingButton(
                      borderRadius: 5,
                      width: 200,
                      color: burntRed,
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 2),
                      ),
                      controller: _btnController,
                      onPressed: _doSomethingLogin),
                ),
              ),
            ),
          ),
        ]));
  }

  Widget regisButton(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: GestureDetector(
                onTap: () {
                  j = 1;
                  setState(() {
                    i = 0;
                  });
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 40,
                  color: sandyBrown,
                ),
              )),
          RegisterBody(),
        ]));
  }

  Widget allButtons(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.5,
          child: RaisedButton(
            child: Text(
              'Login',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            padding: EdgeInsets.all(0),
            onPressed: () {
              setState(() {
                i = 1;
              });
            },
            elevation: 7,
            color: burntRed,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.5,
          child: RaisedButton(
            child: Text(
              'Register',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            padding: EdgeInsets.all(0),
            onPressed: () {
              setState(() {
                i = 2;
              });
            },
            elevation: 7,
            color: burntRed,
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (i == 0) {
      return allButtons(context);
    } else if (i == 1) {
      return loginButtton(context);
    } else if (i == 2) {
      return regisButton(context);
    }
  }
}

class RegisterBody extends StatefulWidget {
  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody>
    with ColorFile, FirebaseDatabase {
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  void _doSomethingRegister() async {
    var temp = await sendUserData();
    if (temp == null) {
      var temp2 = await registerUser();
      if (temp2 == null) {
        _btnController.success();
        Timer(Duration(seconds: 2), () {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              title: "Congratulations",
              text: "Please Login to continue...",
              confirmBtnColor: burntRed);
          setState(() {
            i = 0;
          });
        });
      } else {
        Timer(Duration(seconds: 2), () {
          _btnController.error();
          CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              title: "Oops...",
              text: "Registration Failed",
              confirmBtnColor: burntRed);
        });
        print('LOGIN FAILED');
        print(temp);
        Timer(Duration(seconds: 4), () {
          _btnController.reset();
        });
      }
    } else {
      Timer(Duration(seconds: 2), () {
        _btnController.error();
        CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: "Oops...",
            text: "Registration Failed",
            confirmBtnColor: burntRed);
      });
      print('LOGIN FAILED');
      print(temp);
      Timer(Duration(seconds: 4), () {
        _btnController.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (j == 1) {
      return Column(children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.8,
          child: ElasticInLeft(
            child: TextField(
              onChanged: (value) {
                email = value;
                name = null;
                phone = null;
                password = null;
                hostel = "none";
              },
              controller: null,
              style: TextStyle(
                fontSize: 16,
              ),
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              textAlign: TextAlign.center,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: 'Email',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                prefixIcon: Icon(
                  Icons.arrow_right,
                  color: sandyBrown,
                  size: 30,
                ),
                suffixIcon: Icon(
                  Icons.arrow_left,
                  color: sandyBrown,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.8,
          child: ElasticInRight(
            child: TextField(
              obscureText: true,
              obscuringCharacter: '*',
              onChanged: (value2) {
                password = value2;
                name = null;
                phone = null;
                hostel = "none";
              },
              controller: null,
              style: TextStyle(
                fontSize: 16,
              ),
              keyboardType: TextInputType.text,
              maxLines: 1,
              textAlign: TextAlign.center,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: 'Password',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                prefixIcon: Icon(
                  Icons.arrow_right,
                  color: sandyBrown,
                  size: 30,
                ),
                suffixIcon: Icon(
                  Icons.arrow_left,
                  color: sandyBrown,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        ZoomIn(
          child: Container(
            height: 40,
            width: 120,
            margin: EdgeInsets.fromLTRB(20, 15, 20, 5),
            child: RaisedButton(
              elevation: 5,
              color: burntRed,
              padding: EdgeInsets.all(0),
              child: Icon(
                Icons.navigate_next,
                size: 40,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  j = 2;
                });
              },
            ),
          ),
        ),
      ]);
    } else if (j == 2) {
      return Column(children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.8,
          child: ElasticInLeft(
            child: TextField(
              controller: null,
              onChanged: (value3) {
                name = value3;

                phone = null;
                hostel = "none";
              },
              style: TextStyle(
                fontSize: 16,
              ),
              keyboardType: TextInputType.name,
              maxLines: 1,
              textAlign: TextAlign.center,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: 'Name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                prefixIcon: Icon(
                  Icons.arrow_right,
                  color: sandyBrown,
                  size: 30,
                ),
                suffixIcon: Icon(
                  Icons.arrow_left,
                  color: sandyBrown,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.8,
          child: ElasticInRight(
            child: TextField(
              controller: null,
              onChanged: (value4) {
                phone = value4;
                hostel = "none";
              },
              style: TextStyle(
                fontSize: 16,
              ),
              keyboardType: TextInputType.phone,
              maxLines: 1,
              textAlign: TextAlign.center,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: 'Phone No.',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                prefixIcon: Icon(
                  Icons.arrow_right,
                  color: sandyBrown,
                  size: 30,
                ),
                suffixIcon: Icon(
                  Icons.arrow_left,
                  color: sandyBrown,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 40,
          width: 120,
          margin: EdgeInsets.fromLTRB(20, 15, 20, 5),
          child: RaisedButton(
            elevation: 5,
            color: burntRed,
            padding: EdgeInsets.all(0),
            child: Icon(
              Icons.navigate_next,
              size: 40,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                j = 3;
              });
            },
          ),
        ),
      ]);
    } else if (j == 3) {
      return Column(children: [
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.8,
          child: ElasticInLeft(
            child: TextField(
              onChanged: (value5) {
                hostel = value5;
              },
              style: TextStyle(
                fontSize: 16,
              ),
              keyboardType: TextInputType.name,
              maxLines: 1,
              textAlign: TextAlign.center,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: 'Hostel (OPTIONAL)',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                prefixIcon: Icon(
                  Icons.arrow_right,
                  color: sandyBrown,
                  size: 30,
                ),
                suffixIcon: Icon(
                  Icons.arrow_left,
                  color: sandyBrown,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 100,
          child: Container(
            child: RoundedLoadingButton(
              borderRadius: 5,
              width: 200,
              color: burntRed,
              child: Text(
                'REGISTER',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 2),
              ),
              controller: _btnController,
              onPressed: _doSomethingRegister,
            ),
          ),
        ),
      ]);
    }
  }
}
