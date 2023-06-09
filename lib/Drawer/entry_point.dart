import 'dart:math';

import 'package:animation/Drawer/home.dart';
import 'package:animation/Drawer/side_menu.dart';
import 'package:flutter/material.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EntryPointState createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  late Animation sacleAnimation;
  bool isSideMenuClose = true;
  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    sacleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF17203A),
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            width: MediaQuery.of(context).size.width / 1.4,
            curve: Curves.fastOutSlowIn,
            left:
                isSideMenuClose ? -MediaQuery.of(context).size.width / 1.4 : 0,
            height: MediaQuery.of(context).size.height,
            child: const SideMenuScreen()),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(animation.value - 30 * animation.value * pi / 180),
          child: Transform.translate(
              offset: Offset(animation.value * 265, 0),
              child: Transform.scale(
                  scale: sacleAnimation.value,
                  child: ClipRRect(
                      borderRadius: isSideMenuClose
                          ? BorderRadius.zero
                          : BorderRadius.circular(24),
                      child: GestureDetector(
                          onHorizontalDragStart: (details) {
                            isSideMenuClose = !isSideMenuClose;
                            if (isSideMenuClose) {
                              animationController.reverse();
                            } else {
                              animationController.forward();
                            }
                            setState(() {});
                          },
                          onHorizontalDragCancel: () {
                            isSideMenuClose = !isSideMenuClose;
                            if (isSideMenuClose) {
                              animationController.reverse();
                            } else {
                              animationController.forward();
                            }
                          },
                          child: const HomePage())))),
        ),
        AnimatedPositioned(
            left: isSideMenuClose ? 0 : 220,
            duration: const Duration(milliseconds: 300),
            child: SafeArea(
              child: InkWell(
                onTap: () {
                  isSideMenuClose = !isSideMenuClose;
                  if (isSideMenuClose) {
                    animationController.reverse();
                  } else {
                    animationController.forward();
                  }
                  setState(() {});
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 16, top: 8),
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 3),
                            blurRadius: 8),
                      ]),
                  child: Icon(isSideMenuClose ? Icons.menu : Icons.close),
                ),
              ),
            ))
      ]),
    );
  }
}
