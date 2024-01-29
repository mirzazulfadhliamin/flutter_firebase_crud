

class PostModel {
  String? id;
  String? post;
  String? title;

  PostModel({this.post, this.title});

  PostModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
    id = json["id"];
  }
    if(json["post"] is String) {
      post = json["post"];
    }
    if(json["title"] is String) {
      title = json["title"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id; 
    _data["post"] = post;
    _data["title"] = title;
    return _data;
  }
}
