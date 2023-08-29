import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/models/todo_list_model.dart';

class TodoController extends GetxController {

  RxList<ToDoListModel> todos = new RxList();

  toDoAdd(ToDoListModel temp){
      todos.add(temp);
  }

  toDoRemove(ToDoListModel temp){
      todos.remove(temp);
  }
  toDoUpdate(ToDoListModel temp, int index){
      todos[index]=temp;
  }

  @override
  void onInit() {
    List? storedTodos = GetStorage().read<List>('todos');

    if (storedTodos != null) {
      todos = storedTodos.map((e) => ToDoListModel.fromJson(e)).toList().obs;
    }

    ever(todos, (_) {
      print("ever");
      GetStorage().write('todos', todos.toList());
    });
    super.onInit();
  }
}