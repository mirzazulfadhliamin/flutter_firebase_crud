import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/model/post_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  TextEditingController title = TextEditingController();
  TextEditingController post = TextEditingController();
  var postList = RxList<PostModel>();
  final db = FirebaseFirestore.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPost();
  }

  void addPost() async {
    try {
      if (title.text.isEmpty) {
        throw Exception("Please enter a title.");
      }
      if (post.text.isEmpty) {
        throw Exception("Please enter the post content.");
      }

      var addpost = PostModel(title: title.text, post: post.text);

      var docRef = await db.collection("post").add(addpost.toJson());

      addpost.id = docRef.id;

      printInfo(info: "Post bertambah with ID: ${docRef.id}");
      getPost();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getPost() async {
    try {
      var posts = await db.collection("post").get();
      postList.clear();
      for (var post in posts.docs) {
        var postData = post.data();
        var postModel = PostModel.fromJson(postData);
        postModel.id = post.id;
        postList.add(postModel);
      }
      print("Get Post");
    } catch (error) {
      print("Error getting posts: $error");
    }
  }

  void deletePost(String postId) async {
    await db.collection("post").doc(postId).delete().whenComplete(() {
      print("Post Deleted with ID: $postId");
    });
    getPost();
  }

  void editPost(String postId, String newTitle, String newPost) async {
    await db.collection("post").doc(postId).update({
      "title": newTitle,
      "post": newPost,
    });
    getPost();
    printInfo(info: "Post updated");
  }
}
