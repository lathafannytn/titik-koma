import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tikom/utils/extentions.dart' as AppExt;

class LoadingDialog {
  static void show(BuildContext context, {required Color barrierColor}) {
    AppExt.hideKeyboard(context);
    showDialog(
      useRootNavigator: !kIsWeb,
      barrierDismissible: false,
      barrierColor: barrierColor,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Material(
            type: MaterialType.transparency,
            child: Center(
              child: Wrap(
                children: [
                  Material(
                    elevation: 10,
                    shadowColor: Colors.black38,
                    color: const Color(0xFF178064),
                    borderRadius: BorderRadius.circular(20),
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            backgroundColor:Color(0xFF178064),
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Loading",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
