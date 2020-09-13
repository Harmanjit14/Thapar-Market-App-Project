import 'package:TMart/colorFile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with ColorFile {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      child: Container(child: Image.asset('lib/assets/1.png')),
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
                      child: Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          alignment: Alignment.bottomCenter,
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
      )),
    );
  }
}

class BottomContainer extends StatefulWidget {
  @override
  _BottomContainerState createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> with ColorFile{
  int i = 0;

  Widget loginButtton(BuildContext context) {
    return Container(child: Text('Login'));
  }

  Widget regisButton(BuildContext context) {
    return Container(child: Text('register'));
  }

  Widget allButtons(BuildContext context) {
    ColorFile obj = new ColorFile();
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
