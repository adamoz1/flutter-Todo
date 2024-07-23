class Todo {
  String? title;
  String? description;
  bool? isCompleted;
  String? complitionDate;

  Todo({this.title, this.description, this.isCompleted, this.complitionDate});

  Todo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    isCompleted = json['isCompleted'];
    complitionDate = json['complitionDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['isCompleted'] = isCompleted;
    data['complitionDate'] = complitionDate;
    return data;
  }
}
