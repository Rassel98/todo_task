import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/interface/todo_interface.dart';
import '../../../data/models/todo_model.dart';
import '../../../data/repository/todo_repository.dart';
import '../../../utils/helpers.dart';

class HomeController extends GetxController {
  RxBool isStatus = false.obs;
  RxBool isLoading = true.obs;
  late TodoInterface taskInterface;
  GlobalKey<FormState> formKeys = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final _taskList = <TodoModel>[].obs;
  List<TodoModel> get getTodoList => _taskList;
  late TodoRepository todoRepository;

  @override
  void onInit() {
    super.onInit();
    todoRepository = TodoRepository();
    getAllTodo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    titleController.clear();
    descriptionController.clear();
    close();
  }

  void insertTodo() async {
    TodoModel taskModel = TodoModel(
      title: titleController.text,
      description: descriptionController.text,
      status: isStatus.value,
      createdTime: DateTime.now(),
    );

    int insertedId = await todoRepository.insertTodo(taskModel);
    if (insertedId > 0) {
      taskModel.id = insertedId;
      _taskList.add(taskModel);
      titleController.clear();
      descriptionController.clear();
      showMessage(title: "Success !!", message: "Data inserted successfully.", duration: 3);
      print('Data inserted successfully. Inserted ID: $insertedId');
    } else {
      showMessage(
        title: "Error",
        message: "Failed to insert data.",
      );
      print('Failed to insert data.');
    }
  }

  void updateTodo(TodoModel model, int index) async {
    if (!formKeys.currentState!.validate()) {
      return;
    }
    TodoModel taskModel = TodoModel(
      id: model.id,
      title: titleController.text,
      description: descriptionController.text,
      status: isStatus.value,
      createdTime: model.createdTime,
    );
    int insertedId = await todoRepository.updateTodo(taskModel);
    if (insertedId > 0) {
      _taskList.removeAt(index);
      _taskList.insert(index, taskModel);
      titleController.clear();
      descriptionController.clear();
      showMessage(title: "Success !!", message: "Todo update successfully.", duration: 3);
    } else {
      showMessage(
        title: "Error",
        message: "Failed to update Todo.",
      );
      print('Failed to update Todo.');
    }
  }

  void deleteTodo(TodoModel taskModel) async {
    int delete = await todoRepository.deleteTodo(taskModel.id!);
    if (delete > 0) {
      _taskList.clear();
      getAllTodo();
      showMessage(title: "Success !!", message: "Todo delete successfully.", duration: 3);
      Get.back();
    } else {
      showMessage(
        title: "Error",
        message: "Failed to delete Todo.",
      );
    }
  }

  void getAllTodo() async {

    var response = await todoRepository.getAllTodos();
    if (response.isNotEmpty) {
      print('All Todo:');
      _taskList.addAll(response);
      isLoading(false);
    } else {
      isLoading(false);
      print('No Todo found in the database.');
    }
  }

  void close() => todoRepository.close();


}
