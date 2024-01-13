import '../db/local_db_helper.dart';
import '../interface/todo_interface.dart';
import '../models/todo_model.dart';

class TodoRepository extends TodoInterface {
  DBHelper dbHelper = DBHelper.instance;
  @override
  Future<List<TodoModel>> getAllTodos() => dbHelper.getAllTodos();

  @override
  Future<TodoModel?> getTodoById(int taskId) => dbHelper.getTodoById(taskId);

  @override
  Future<int> insertTodo(TodoModel taskModel) => dbHelper.insertTodo(taskModel);

  @override
  Future close() => dbHelper.close();

  @override
  Future<int> deleteTodo(int id) => dbHelper.deleteTodo(id);

  @override
  Future<int> updateTodo(TodoModel taskModel) => dbHelper.updateTask(taskModel);
}
