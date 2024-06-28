class Todo {
  String? title;
  String? description;
  bool? isCompleted;

  Todo({this.title, this.description, this.isCompleted});

  Todo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['isCompleted'] = this.isCompleted;
    return data;
  }
}
