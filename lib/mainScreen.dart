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
  final duration = Duration(milliseconds: 500);
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
          left: isSiderbarOpenAsync.data ? 0 : 0,
          right:isSiderbarOpenAsync.data ? 0 : MediaQuery.of(context).size.width - 45,
          child: Row(children: [
            Expanded(
                child: Container(
              color: charcoal,
            )),
            Align(
              alignment: Alignment(0, -0.8),
              child: GestureDetector(
                onTap: (){
                  onIconPressed();
                },
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
            )
          ]),
        );
      },
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
