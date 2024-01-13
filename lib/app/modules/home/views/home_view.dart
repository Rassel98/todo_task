import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'todo_details_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : controller.getTodoList.isEmpty
              ? const Center(
                  child: Text("No Data Found !!"),
                )
              : SafeArea(
                  child: ListView.builder(
                    itemCount: controller.getTodoList.length,
                    itemBuilder: (context, index) {
                      final model = controller.getTodoList[index];
                      return GestureDetector(
                        onTap: () => Get.to(
                          () => TodoDetailsView(
                            todoModel: model,
                            idx: index,
                          ),
                          transition: Transition.leftToRight,
                          duration: const Duration(milliseconds: 260),
                          curve: Curves.easeInOut,
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffD4D5D6).withOpacity(0.7),
                                spreadRadius: 0,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Title : ',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'muli',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF404144)),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: model.title ?? "",
                                        style: const TextStyle(
                                            fontFamily: 'HindSiliguri',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Description : ',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'muli',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF404144)),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: model.description ?? "",
                                        style: const TextStyle(
                                            fontFamily: 'HindSiliguri',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Status : ',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: model.status ? const Color(0xff268A58) : Colors.red,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(width: 0.5, color: Colors.pink),
                                      ),
                                      child: Text(
                                        model.status ? 'Active' : "Inactive",
                                        style: const TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      );
                    },
                  ),
                )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => createTodo(controller),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> createTodo(HomeController controller) async {
    return Get.defaultDialog(
      title: "Add new todo",
      content: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: SingleChildScrollView(
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please write todo description ';
                        }
                        return null;
                      },
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
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Colors.blueAccent),
                            onPressed: () async {
                              if (!controller.formKeys.currentState!.validate()) {
                                return;
                              }
                              Get.back();
                              controller.insertTodo();
                            },
                            child: const Text(
                              'Save',
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Colors.grey),
                            onPressed: () => Get.back(),
                            child: const Text(
                              'Close',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
