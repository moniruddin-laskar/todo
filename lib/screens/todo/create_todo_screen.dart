import 'dart:math';

import 'package:alarm/alarm.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:todo/constant/colors.dart';
import 'package:todo/controllers/todo_controller.dart';
import 'package:todo/main.dart';
import 'package:todo/models/todo_list_model.dart';
import 'package:todo/utils/widgets/common_widgets.dart';
import 'package:todo/utils/widgets/success_page.dart';

class CreateToDoScreen extends StatefulWidget {
  CreateToDoScreen({super.key, this.isEditMode, this.toDoItem, this.indexData});

  final String? isEditMode;
  final ToDoListModel? toDoItem;
  final int? indexData;

  @override
  State<CreateToDoScreen> createState() => _CreateToDoScreenState();
}

class _CreateToDoScreenState extends State<CreateToDoScreen> {
  returnTwoStep() async {
    await Future<void>.delayed(const Duration(seconds: 2), () async {
      Navigator.pop(context, 'OK');
      Navigator.pop(context, 'OK');
    });
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController toDoTitelController = TextEditingController();

  TextEditingController toDoAlarmDate = TextEditingController();

  TextEditingController toDoAlarmTime = TextEditingController();

  DateTime toDoAlarmDateAndTime = DateTime.now();

  bool remainderSetError = false;

  bool statusSubmitDone = false;

  Future showToDoAlarmDateAndTime() async {
    DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime(2018, 3, 5),
        maxTime: DateTime(2040, 6, 7), onChanged: (date) {
      setState(() {});
    }, onConfirm: (date) {
      toDoAlarmDateAndTime = date;
      toDoAlarmDate.text = AppFonts.dateAndTimeFormatChanged(date.toString());
      var alarmTimeDef = daysBetween(DateTime.now(), toDoAlarmDateAndTime);
      if (alarmTimeDef > 0) {
        setState(() {
          remainderSetError = false;
          isPress = false;
        });
      } else {
        showSnackbar(context, "Remainder should be future date!!");
        setState(() {
          remainderSetError = true;
          isPress = true;
        });
      }
      setState(() {});
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  // Future showScheduleDate() async {
  //   DateTime? date = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime(3000),
  //   );
  //   if (date != null) {
  //     toDoAlarmDate.text = date.toString();

  //     // toDoAlarmDate.text = AppFonts.dateFormatChanged(date.toString());
  //   }
  // }

  Future toDoAlarmTimeValue() async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      // print("pickedTime.format(context)"); //output 10:51 PM
      // print(pickedTime.format(context)); //output 10:51 PM
      // DateTime parsedTime =
      //     DateFormat.jm().parse(pickedTime.format(context).toString());
      // //converting to DateTime so that we can further format on different pattern.
      // print("parsedTime"); //output 1970-01-01 22:53:00.000
      // print(parsedTime); //output 1970-01-01 22:53:00.000
      // String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
      // print(formattedTime); //output 14:59:00
      // //DateFormat() is from intl package, you can format the time on any pattern you need.

      setState(() {
        toDoAlarmTime.text = pickedTime.format(context).toString();
        // widget.startTimeCb(toDoAlarmTime.text.toString());
        //set the value of text field.
        // timeinput.text = formattedTime; //set the value of text field.
      });
    } else {
      print("Time is not selected");
    }
  }

  Future<void> addToDoList() async {
    int rowId = Random().nextInt(100);

    if (toDoAlarmDate.text != "" && remainderSetError == false) {
      final alarmSettings = AlarmSettings(
        id: rowId,
        dateTime: toDoAlarmDateAndTime,
        assetAudioPath: 'assets/audio/Alarm.mp3',
        loopAudio: false,
        vibrate: true,
        volumeMax: true,
        fadeDuration: 3.0,
        notificationTitle: 'To Do List Alarm',
        notificationBody: toDoTitelController.text.toString(),
        enableNotificationOnKill: true,
      );
      await Alarm.set(alarmSettings: alarmSettings);
      await AndroidAlarmManager.oneShotAt(
          toDoAlarmDateAndTime, rowId, printHello);
    }
    if (toDoTitelController.text.toString() == "") {
      showSnackbar(context, "Mandatory to fill Task Section!!");
      setState(() {
        isPress = false;
      });
    } else {
      if (widget.isEditMode == "yes") {
        toDoListData.toDoUpdate(
            ToDoListModel(
              title: toDoTitelController.text,
              isAlarmSet: toDoAlarmDate.text != "" ? true : false,
              alarmDate: toDoAlarmDate.text.toString(),
              createdOn: widget.toDoItem!.createdOn,
              toDoStatus: widget.toDoItem!.toDoStatus,
            ),
            widget.indexData ?? 0);
        setState(() {
          statusSubmitDone = true;
        });
      } else {
        if (remainderSetError == false) {
          toDoListData.toDoAdd(ToDoListModel(
            title: toDoTitelController.text,
            isAlarmSet: toDoAlarmDate.text != "" ? true : false,
            alarmDate: toDoAlarmDate.text.toString(),
            createdOn: currentDate.toString(),
            toDoStatus: false,
          ));
          setState(() {
            statusSubmitDone = true;
          });
        }
      }
      if (statusSubmitDone) {
        Navigator.of(context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) {
              return SuccessScreen();
            }));
        returnTwoStep();
      }
    }
  }

  TodoController toDoListData = Get.find();

  DateTime currentDate = DateTime.now();

  bool isPress = false;

  @override
  void initState() {
    if (widget.isEditMode == "yes") {
      toDoTitelController.text = widget.toDoItem!.title.toString();
      toDoAlarmDate.text = widget.toDoItem!.alarmDate.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: white,
        ),
        leading: IconButton(
          icon: Icon(Icons.turn_left, color: white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: appBarColor,
        title: textBold(color: white, maxLine: 1, size: 20, text: "New Task"),
      ),
      backgroundColor: appCOlor,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            isPress = true;
          });
          addToDoList();
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
        backgroundColor: white,
        child: isPress
            ? progressIndicator(context)
            : Icon(Icons.done, color: black, size: 35),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 18,
                top: 20,
              ),
              child: Row(
                children: [
                  textBold(
                    text: "What is to be done ? ",
                    size: 16,
                    color: white,
                  ),
                  textBold(color: red, maxLine: 1, size: 18, text: "*")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 18,
                top: 8,
                right: 18,
              ),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                style: TextStyle(color: white),
                controller: toDoTitelController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  errorBorder: customOutlineBorder(),
                ),
              ),
            ),
            VSpace(40),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                top: 20,
              ),
              child: Row(
                children: [
                  textBold(
                    text: "Set Remainder ",
                    size: 16,
                    color: white,
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 15,
                ),
                child: Row(
                  children: [
                    Container(
                        width: toDoAlarmDate.text != ""
                            ? fullWidth(context) * 0.80
                            : fullWidth(context) * 0.90,
                        padding: EdgeInsets.all(10),
                        height: fullHeight(context) * 0.06,
                        child: Center(
                            child: TextField(
                          style:
                              TextStyle(color: remainderSetError ? red : white),
                          controller: toDoAlarmDate,
                          decoration: InputDecoration(
                            icon: Icon(Icons.schedule,
                                color: remainderSetError ? red : white,
                                size: 25),
                          ),
                          readOnly: true,
                          onTap: () async {
                            showToDoAlarmDateAndTime();
                          },
                        ))),
                    toDoAlarmDate.text != ""
                        ? SizedBox(
                            width: fullWidth(context) * 0.10,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  toDoAlarmDate.text = "";
                                  remainderSetError = false;
                                  isPress = false;
                                });
                              },
                              child: Icon(Icons.close, color: white, size: 30),
                            ),
                          )
                        : HSpace(1),
                  ],
                )),
            VSpace(10),
          ],
        ),
      ),
    );
  }
}
