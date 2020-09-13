import 'dart:async';

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
  final duration = Duration(milliseconds: 500);
  bool isBarOpen = false;
  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: duration);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    sideBarController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isBarOpen ? 0 : 0,
      right: isBarOpen ? 0 : MediaQuery.of(context).size.width - 45,
      child: Row(children: [
        Expanded(
            child: Container(
          color: charcoal,
        )),
        Align(
          alignment: Alignment(0, -0.8),
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
        )
      ]),
    );
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
    );
  }
}
