import 'dart:async';
import 'package:TMart/firebaseDatabase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:TMart/colorFile.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with FirebaseDatabase {
  @override
  void dispose() {
    logoutUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MainBody(),
            SideNavBar(),
          ],
        ),
      ),
    );
  }
}

class SideNavBar extends StatefulWidget {
  @override
  _SideNavBarState createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar>
    with
        SingleTickerProviderStateMixin<SideNavBar>,
        ColorFile,
        FirebaseDatabase {
  AnimationController animationController;
  StreamController<bool> sideBarController;
  Stream<bool> isSideBarOpenedStream;
  final duration = Duration(milliseconds: 200);
  StreamSink<bool> isSidebarOpenedSink;

  void onIconPressed() {
    final animationStatus = animationController.status;
    final isAnimationComplete = animationStatus == AnimationStatus.completed;
    if (isAnimationComplete) {
      isSidebarOpenedSink.add(false);
      animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      animationController.forward();
    }
  }

  @override
  void initState() {
    setState(() {
      getUser();
    });

    animationController = AnimationController(vsync: this, duration: duration);
    sideBarController = PublishSubject<bool>();
    isSideBarOpenedStream = sideBarController.stream;
    isSidebarOpenedSink = sideBarController.sink;
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    sideBarController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSideBarOpenedStream,
      builder: (context, isSiderbarOpenAsync) {
        return AnimatedPositioned(
          duration: duration,
          top: 0,
          bottom: 0,
          left:
              isSiderbarOpenAsync.data ? 0 : -MediaQuery.of(context).size.width,
          right: isSiderbarOpenAsync.data
              ? 0
              : MediaQuery.of(context).size.width - 35,
          child: Row(children: [
            Expanded(
                child: Container(
              child: Column(children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: orangeYellow),
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(children: [
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: "maven",
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      email,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "maven",
                          letterSpacing: 1.5),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              FlatButton(
                                  onPressed: () {
                                    print('pressed');
                                  },
                                  child: Icon(Icons.settings)),
                              Text(
                                'Settings',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              FlatButton(
                                  onPressed: () async {
                                    logoutUser();
                                    Navigator.pushReplacementNamed(
                                        context, '/');
                                  },
                                  child: Icon(
                                    Icons.exit_to_app,
                                    size: 28,
                                  )),
                              Text(
                                'Logout',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          color: persianGreen,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Home',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: "maven",
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          color: persianGreen,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Wellbeing',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: "maven",
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          color: persianGreen,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Utilities',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: "maven",
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          color: persianGreen,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Fast Food',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: "maven",
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.navigate_next,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ]),
              color: charcoal,
            )),
            Align(
              alignment: Alignment(0, -0.7),
              child: GestureDetector(
                onTap: () {
                  onIconPressed();
                },
                child: ClipPath(
                  clipper: CustomMenuClipper(),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 110,
                    width: 35,
                    color: charcoal,
                    child: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        size: 25,
                        color: Colors.white,
                        progress: animationController.view),
                  ),
                ),
              ),
            )
          ]),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> with ColorFile {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = charcoal;
    Path path = Path();
    final width = size.width;
    final height = size.height;
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Layout1(),
    );
  }
}

class Layout1 extends StatefulWidget {
  @override
  _Layout1State createState() => _Layout1State();
}

class _Layout1State extends State<Layout1> with ColorFile, FirebaseDatabase {
  Widget whatsNewLayout(
      BuildContext context, DocumentSnapshot documentSnapshot) {
    String url = documentSnapshot.get('img');
    return Container(
      height: 500,
      width: MediaQuery.of(context).size.width,
      child: Image.network(
        url,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget topOffersLayout(
      BuildContext context, DocumentSnapshot documentSnapshot) {
    String from = documentSnapshot.get('from');
    String what = documentSnapshot.get('what');
    String code = documentSnapshot.get('code');
    return Container(
      width: MediaQuery.of(context).size.width*0.8,

      decoration: BoxDecoration(
          color: sandyBrown, borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            from,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              what,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "USE CODE : $code",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: true,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                child: Text(
                  'Whats up?',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "maven",
                      fontSize: 33,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey[200]),
                child: IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.black,
                    ),
                    onPressed: () {}),
              ),
              SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey[200]),
                child: IconButton(
                    icon: Icon(
                      Icons.shopping_basket,
                      size: 30,
                      color: Colors.black,
                    ),
                    onPressed: () {}),
              )
            ],
          ),
        ),
        // Container(
        //   height: MediaQuery.of(context).size.height * 0.3,
        //   margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        //   child: StreamBuilder<QuerySnapshot>(
        //     stream:
        //         FirebaseFirestore.instance.collection("whatsNew").snapshots(),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         return ListView.builder(
        //           scrollDirection: Axis.horizontal,
        //           itemCount: snapshot.data.docs.length,
        //           itemBuilder: (context, index) {
        //             return whatsNewLayout(context, snapshot.data.docs[index]);
        //           },
        //         );
        //       } else
        //         return Center(child: Text('Error in fetching Data...'));
        //     },
        //   ),
        // ),
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: MediaQuery.of(context).size.height * 0.42,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: burntRed, borderRadius: BorderRadius.circular(10)),
            child: Column(children: [
              Container(
                //alignment: Alignment.bottomLeft,
                margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Text('Top Offers',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 20,
                        fontFamily: "maven",
                        fontWeight: FontWeight.bold)),
              ),
              Expanded(
                  child: Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("offers")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          return topOffersLayout(
                              context, snapshot.data.docs[index]);
                        },
                      );
                    } else
                      return Center(child: Text('Error in fetching Data...'));
                  },
                ),
              ))
            ]),
          ),
        )
      ],
    );
  }
}
