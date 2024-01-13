import '../models/todo_model.dart';

abstract  class  TodoInterface {
  Future<int> insertTodo(TodoModel taskModel);
  Future<TodoModel?> getTodoById(int taskId);
  Future<List<TodoModel>> getAllTodos();
  Future<int> updateTodo(TodoModel taskModel);
  Future<int> deleteTodo(int id);
  Future close();
}
