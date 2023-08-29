import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/constant/colors.dart';

OutlineInputBorder customOutlineBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.grey,
      width: 1.5,
    ),
  );
}

///text-Regular
Widget textRegular({
  String text = "",
  double size = 10,
  Color? color,
  int? maxLine,
  dynamic alignment,
}) {
  return Text(
    text,
    maxLines: maxLine,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    textAlign: alignment ?? TextAlign.left,
  );
}

///text-Bold Style
Widget textBold({
  String text = "",
  double size = 10,
  Color? color,
  int? maxLine,
}) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    maxLines: maxLine,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
    ),
  );
}

///text-Semi Bold Style
Widget textSemiBold({
  String text = "",
  double size = 10,
  Color? color,
  int? maxLine,
}) {
  return Text(
    text,
    maxLines: maxLine,
    // textAlign: TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
  );
}

///Pop Navigate
goBack(BuildContext context) {
  Navigator.of(context).pop();
}

///SnackBar
showSnackbar(
  BuildContext context,
  String content,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: grey,
      content: textBold(
        text: content,
        size: 16,
        color: white,
      ),
    ),
  );
}

///Vertical Space
Widget VSpace(
  double h,
) {
  return SizedBox(
    height: h,
  );
}

///Horizontal Space
Widget HSpace(
  double w,
) {
  return SizedBox(
    width: w,
  );
}

///Custom Indicator
Widget progressIndicator(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(
        backgroundColor: white,
        color: black,
      ),
    ),
  );
}

double fullWidth(BuildContext context) {
  // return MediaQuery.of(context).size.width;
  // print(MediaQuery.of(context).orientation);
  // if (MediaQuery.of(context).orientation == Orientation.portrait) {
  //   return MediaQuery.of(context).size.width;
  // } else {
  //   return MediaQuery.of(context).size.height;
  // }
  return MediaQuery.of(context).size.width;
}

double pixelRatio(BuildContext context) {
  if (MediaQuery.of(context).orientation == Orientation.portrait) {
    return MediaQuery.of(context).size.height /
        MediaQuery.of(context).size.width;
  } else {
    return MediaQuery.of(context).size.width /
        MediaQuery.of(context).size.height;
  }
}

double fullHeight(BuildContext context) {
  if (MediaQuery.of(context).orientation == Orientation.portrait) {
    return MediaQuery.of(context).size.height;
  } else {
    return MediaQuery.of(context).size.width;
  }
}

class AppFonts {
  ///Dateformatter Variable
  static var newDate;

  ///Date Formatter
  static dateAndTimeFormatChanged(date) {
    // var d = date.split("").toString();
    newDate = DateFormat("d MMM, yyyy, HH:mm").format(
      DateTime.parse(
        date,
      ),
    );

    return newDate;
  }

  static dateFormatChanged(date) {
    // var d = date.split("").toString();
    newDate = DateFormat("d MMM, yyyy").format(
      DateTime.parse(
        date,
      ),
    );

    return newDate;
  }
}

Widget tabBarDesign({
  String text = "",
  double size = 10,
  Color? color,
  int? maxLine,
  dynamic alignment,
}) {
  return Text(
    text,
    maxLines: maxLine,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    textAlign: alignment ?? TextAlign.left,
  );
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day,from.hour,from.minute);
  to = DateTime(to.year, to.month, to.day,to.hour,to.minute);
  return (to.difference(from).inMinutes);
}
