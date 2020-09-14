import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:TMart/colorFile.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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
    with SingleTickerProviderStateMixin<SideNavBar>, ColorFile {
  AnimationController animationController;
  StreamController<bool> sideBarController;
  Stream<bool> isSideBarOpenedStream;
  final duration = Duration(milliseconds: 400);
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
              : MediaQuery.of(context).size.width - 45,
          child: Row(children: [
            Expanded(
                child: Container(
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
                        color: orangeYellow,
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

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;
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

class _Layout1State extends State<Layout1> with ColorFile {
  @override
  Widget build(BuildContext context) {
    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.arrow_left,
                  size: 30,
                ),
                hintText: 'Search Here...',
                prefixIcon: Icon(
                  Icons.arrow_right,
                  size: 30,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
        Container(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child:
                            Container(color: burntRed, child: Text('$index')),
                      );
                    }),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [],
          ),
        ),
      ],
    );
  }
}
