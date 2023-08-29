import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/constant/colors.dart';
import 'package:todo/controllers/todo_controller.dart';
import 'package:todo/utils/widgets/common_widgets.dart';
import 'package:todo/utils/widgets/todo_list_table.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TodoController toDoListData = Get.put(TodoController());

  TextEditingController searchController = TextEditingController();

  bool isSearch = false;

  String searchValue = "";

  @override
  Widget build(BuildContext context) {
    return isSearch
        ? Scaffold(
            appBar: AppBar(
                iconTheme: IconThemeData(
                  color: white,
                ),
                leading: IconButton(
                  icon: Icon(Icons.turn_left, color: white),
                  onPressed: () {
                    setState(() {
                      isSearch = false;
                    });
                  },
                ),
                backgroundColor: appBarColor,
                // The search area here
                title: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          searchValue = searchController.text.toString();
                        });
                      },
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                searchValue = "";
                                searchController.text = "";
                              });
                            },
                          ),
                          hintText: 'Search...',
                          border: InputBorder.none),
                    ),
                  ),
                )),
            backgroundColor: appCOlor,
            body: Column(
              children: [
                Obx(() {
                  // ignore: invalid_use_of_protected_member
                  return ToDoListTable(
                    // ignore: invalid_use_of_protected_member
                    itemlist: toDoListData.todos.value,
                    searchValue: searchValue,
                  );
                }),
              ],
            ),
          )
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: textBold(
                    color: white, maxLine: 1, size: 20, text: "All Lists"),
                leading: Icon(
                  Icons.check_circle,
                  color: white,
                  size: 35.0,
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 10),
                    child: InkWell(
                      onTap: () {
                        // Get.toNamed("/search");
                        setState(() {
                          isSearch = true;
                        });
                      },
                      child: Icon(
                        Icons.search,
                        color: white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
                backgroundColor: appBarColor,
                elevation: 10,
                bottom: TabBar(
                  indicatorColor: red,
                  tabs: [
                    Tab(
                      child: textBold(
                          color: white,
                          maxLine: 1,
                          size: 15,
                          text: "IN-COMPLETE"),
                    ),
                    Tab(
                      child: textBold(
                          color: white,
                          maxLine: 1,
                          size: 15,
                          text: "COMPLETED"),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Get.toNamed("/create-todo");
                },
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                backgroundColor: white,
                child: Icon(Icons.add, color: black, size: 35),
              ),
              backgroundColor: appCOlor,
              body: TabBarView(
                children: [
                  Column(
                    children: [
                      Obx(() {
                        // ignore: invalid_use_of_protected_member
                        return ToDoListTable(
                          // ignore: invalid_use_of_protected_member
                          itemlist: toDoListData.todos.value,
                          statusCheck: false,
                          // searchValue: "",
                        );
                      }),
                    ],
                  ),
                  Column(
                    children: [
                      Obx(() {
                        // ignore: invalid_use_of_protected_member
                        return ToDoListTable(
                          // ignore: invalid_use_of_protected_member
                          itemlist: toDoListData.todos.value,
                          statusCheck: true,
                          // searchValue: "",
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
