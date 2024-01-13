class TodoModel {
  int? id;
  String title;
  String? description;
  bool status;
  DateTime createdTime;

  TodoModel({this.id, required this.title, this.description, required this.status, required this.createdTime});

  Map<String, dynamic> toMap() {
    return {
      tabTaskColId: id ?? id,
      tabTaskColTitle: title,
      tabTaskColDescription: description,
      tabTaskColStatus: status ? 1 : 0,
      tabTaskColCreatedAt: createdTime.toIso8601String(),
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map[tabTaskColId] as int?,
      title: map[tabTaskColTitle] as String,
      description: map[tabTaskColDescription] as String?,
      status: map[tabTaskColStatus] == 1,
      createdTime: DateTime.parse(map[tabTaskColCreatedAt] as String),
    );
  }

  @override
  String toString() {
    return 'TaskModel{id: $id, title: $title, description: $description, status: $status, createdTime: $createdTime}';
  }
}

const String tableTask = 'tb_task';
const String tabTaskColId = '_id';
const String tabTaskColTitle = 'title';
const String tabTaskColDescription = 'description';
const String tabTaskColStatus = 'status';
const String tabTaskColCreatedAt = 'createdAt';
