import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/constant/colors.dart';
import 'package:todo/controllers/todo_controller.dart';
import 'package:todo/models/todo_list_model.dart';
import 'package:todo/screens/todo/create_todo_screen.dart';
import 'package:todo/utils/widgets/common_widgets.dart';

// ignore: must_be_immutable
class RowItem extends StatefulWidget {
  ToDoListModel itemModel;
  int index;
  RowItem({super.key, required this.itemModel, required this.index});

  @override
  State<RowItem> createState() => _RowItemState();
}

class _RowItemState extends State<RowItem> {
  bool isChecked = false;
  TodoController toDoListData = Get.find();
  @override
  Widget build(BuildContext context) {
    isChecked = widget.itemModel.toDoStatus;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.00),
      child: Card(
        color: cardColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: fullWidth(context) * 0.10,
                    child: Checkbox(
                      checkColor: Colors.white,
                      value: isChecked,
                      onChanged: (bool? value) {
                        widget.itemModel.toDoStatus = !isChecked;
                        toDoListData.toDoUpdate(widget.itemModel, widget.index);
                      },
                    ),
                  ),
                  HSpace(10),
                  InkWell(
                    onTap: () {
                      Get.to(
                        () => CreateToDoScreen(
                          isEditMode: "yes",
                          toDoItem: widget.itemModel,
                          indexData: widget.index,
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          // color: red,
                          // width: pixelRatio(context) * 120,
                          width: fullWidth(context) * 0.65,
                          child: textSemiBold(
                              color: black,
                              maxLine: 10,
                              size: 16,
                              text: widget.itemModel.title.toString()),
                        ),
                        VSpace(5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            textSemiBold(
                                color: black,
                                maxLine: 1,
                                size: 12,
                                text: AppFonts.dateFormatChanged(
                                    widget.itemModel.createdOn.toString())),
                            HSpace(20),
                            widget.itemModel.isAlarmSet
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        color: grey,
                                        size: 18,
                                        Icons.schedule,
                                      ),
                                      HSpace(5),
                                      textSemiBold(
                                          color: black,
                                          maxLine: 1,
                                          size: 12,
                                          text: widget.itemModel.alarmDate
                                              .toString()),
                                    ],
                                  )
                                : Container(
                                    // child: textBold(
                                    //     color: black,
                                    //     text: widget.itemModel.isAlarmSet
                                    //         .toString()),
                                    ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  print("object");
                  toDoListData.toDoRemove(widget.itemModel);
                  showSnackbar(context, "Successfully Remove Task!!");
                },
                child: Center(
                  child: Icon(Icons.delete, color: red, size: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
