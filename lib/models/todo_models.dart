class TodoModel {
  int? id;
  int? userId;
  String? title;
  String? content;

  TodoModel({
    this.id,
    required this.userId,
    required this.title,
    required this.content,
  });

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      content: map['content'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'content': content,
    };
  }
}
