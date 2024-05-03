import 'package:flutter/material.dart';
import 'package:tikom/common/widgets.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  final Widget child;

  const TPrimaryHeaderContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgesWidget(
      child: SizedBox(
        height: 400,
        child: Container(
          color: Colors.black,
          child: Stack(
            children: [
              Positioned(
                top: -150, 
                right: -250, 
                child: TCircularContainer(backgroundColor: Colors.white.withOpacity(0.1)),
              ),
              Positioned(
                top: 100, 
                right: -300, 
                child: TCircularContainer(backgroundColor: Colors.white.withOpacity(0.1)),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

