import 'package:flutter/material.dart';

class TCircularContainer extends StatelessWidget {
  final Color backgroundColor;

  const TCircularContainer({Key? key, required this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
    );
  }
}

class TCurvedEdgesWidget extends StatelessWidget {
  final Widget child;

  const TCurvedEdgesWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
