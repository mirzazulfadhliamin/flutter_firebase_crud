import 'package:crud_firebase/controller/post_ctr.dart';
import 'package:crud_firebase/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

const primaryColor = Color(0xFF546E7A);
const onPrimaryColor = Colors.white;
const surfaceColor = Colors.white;
const onSurfaceColor = Colors.black;

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    PostController controller = Get.put(PostController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: Text("MATENI"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextFormField(
                controller: controller.title,
                decoration: InputDecoration(
                  hintText: "Enter Title",
                  filled: true,
                  fillColor: surfaceColor, 
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10), 
                    borderSide: BorderSide(
                        color: primaryColor, width: 2), 
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: TextStyle(
                  color: onSurfaceColor, 
                ),
              ),
            ),
            SizedBox(height: 15), 
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: controller.post,
                decoration: InputDecoration(
                  hintText: "Enter Post",
                  filled: true,
                  fillColor: surfaceColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: TextStyle(
                  color: onSurfaceColor,
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                controller.addPost();
              },
              child: Text("SAVE"),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                height: 500,
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.postList.length,
                    itemBuilder: (context, index) {
                      var element = controller.postList[index];
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            element.title.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          subtitle: Text(
                            element.post.toString(),
                            style: TextStyle(fontSize: 16.0),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.deletePost(element.id!);
                                },
                                icon: Icon(Icons.delete),
                              ),
                              IconButton(
                                onPressed: () {
                                  _showEditDialog(context, controller, element);
                                },
                                icon: Icon(Icons.edit),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(
      BuildContext context, PostController controller, PostModel postModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Post"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: controller.title,
                decoration: InputDecoration(
                  hintText: "Enter Title",
                  fillColor: Colors.deepPurple.shade200,
                  filled: true,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: controller.post,
                decoration: InputDecoration(
                  hintText: "Enter Post",
                  fillColor: Colors.deepPurple.shade200,
                  filled: true,
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                controller.editPost(
                    postModel.id!, controller.title.text, controller.post.text);
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
