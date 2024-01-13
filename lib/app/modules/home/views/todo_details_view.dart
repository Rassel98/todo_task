import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/todo_model.dart';
import '../controllers/home_controller.dart';

class TodoDetailsView extends StatelessWidget {
  final TodoModel? todoModel;
  final int? idx;
  const TodoDetailsView({Key? key, this.todoModel, this.idx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    if (todoModel != null) {
      controller.titleController.text = todoModel!.title;
      controller.descriptionController.text = todoModel!.description ?? "";
      controller.isStatus(todoModel!.status);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Todo"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            controller.titleController.clear();
            controller.descriptionController.clear();
            controller.isStatus(false);
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Form(
            key: controller.formKeys,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    cursorColor: const Color(0xffff3333),
                    keyboardType: TextInputType.text,
                    controller: controller.titleController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please write your todo title';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        hintText: "Enter todo title",
                        hintStyle: const TextStyle(color: Colors.grey),
                        labelText: "Title",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.9),
                            ))),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    cursorColor: const Color(0xffff3333),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    controller: controller.descriptionController,
                    maxLines: 5,
                    expands: false,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Please write task description ';
                    //   }
                    //   return null;
                    // },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        hintText: "Write your todo description",
                        hintStyle: const TextStyle(color: Colors.grey),
                        labelText: "Description",
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.9),
                            ))),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          value: controller.isStatus.value,
                          checkColor: Colors.white,
                          activeColor: const Color(0xFFC81E26),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          onChanged: (v) {
                            controller.isStatus(v);
                          }),
                      const Text(
                        'Status',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Get.back();
                            controller.updateTodo(todoModel!, idx!);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            "Update",
                            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            Get.back();
                            controller.deleteTodo(todoModel!);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            "Delete",
                            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
