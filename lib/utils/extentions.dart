import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tikom/utils/routes.dart' as AppRoute;


void backToRoot(context) {
  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
}

void popUntilRoot(context) {
  Navigator.popUntil(context, ModalRoute.withName('/'));
}

void backToMain(context) {
  Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
}

void hideKeyboard(context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

void popScreen(BuildContext context, [dynamic data]) {
  Navigator.pop(context, data);
}

enum RouteTransition { slide, dualSlide, fade, material, cupertino, slideUp }

Future pushScreen(BuildContext context, Widget buildScreen,
    [RouteTransition routeTransition = RouteTransition.slide,
    Widget? fromScreen]) async {
  dynamic data;
  switch (routeTransition) {
    case RouteTransition.slide:
      data =
          await Navigator.push(context, AppRoute.SlideRoute(page: buildScreen));
      break;
    case RouteTransition.fade:
      data =
          await Navigator.push(context, AppRoute.FadeRoute(page: buildScreen));
      break;
    case RouteTransition.material:
      data = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => buildScreen));
      break;
    case RouteTransition.dualSlide:
      data = await Navigator.push(
          context,
          AppRoute.DualSlideRoute(
              enterPage: buildScreen, exitPage: fromScreen ?? context.widget));
      break;
    case RouteTransition.cupertino:
      data = await Navigator.push(
          context,
          CupertinoPageRoute(
              fullscreenDialog: true, builder: (context) => buildScreen));
      break;
    case RouteTransition.slideUp:
      data = await Navigator.push(
          context, AppRoute.SlideUpRoute(page: buildScreen));
      break;
  }
  return data;
}

void pushAndRemoveScreen(BuildContext context, {required Widget pageRef}) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => pageRef),
      (Route<dynamic> route) => false);
}

String toRupiah(int number) {
  if (number == null) return "-";
  final currencyFormatter = NumberFormat('#,##0', 'ID');
  return currencyFormatter.format(number);
}

String shortCurr(int number) {
  return number < 1000000 ? toRupiah(number) : convCurr(number);
}

String convCurr(int number) {
  final currencyFormatter = NumberFormat.compact(locale: 'ID');
  return currencyFormatter.format(number);
}
