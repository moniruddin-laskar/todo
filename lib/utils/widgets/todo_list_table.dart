import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controllers/todo_controller.dart';
import 'package:todo/models/todo_list_model.dart';
import 'package:todo/utils/widgets/table_item.dart';

// ignore: must_be_immutable
class ToDoListTable extends StatefulWidget {
  List<ToDoListModel> itemlist;

  bool? statusCheck;

  String? searchValue;

  ToDoListTable(
      {super.key, required this.itemlist, this.statusCheck, this.searchValue});

  @override
  State<ToDoListTable> createState() => _ToDoListTableState();
}

class _ToDoListTableState extends State<ToDoListTable> {
  // bool isChecked = false;
  TodoController toDoListData = Get.find();

  List<ToDoListModel> filterredList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterredList = widget.itemlist;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: filterredList.length,
          itemBuilder: (context, index) {
            if (widget.searchValue != null) {
              if (filterredList[index].title.contains(widget.searchValue)) {
                return RowItem(itemModel: filterredList[index], index: index);
              }
              return Container();
            } else {
              if (filterredList[index].toDoStatus == widget.statusCheck) {
                return RowItem(itemModel: filterredList[index], index: index);
              }
              return Container();
            }
          }),
    );
  }
}
