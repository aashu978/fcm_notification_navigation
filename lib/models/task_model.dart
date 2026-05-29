class Task {
  final String id;
  final String title;
  final String description;
  final String assignee;
  final DateTime dueDate;
  final String priority;
  final String status;
  final String category;
  final int estimatedHours;
  final List<String> tags;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.assignee,
    required this.dueDate,
    required this.priority,
    required this.status,
    required this.category,
    required this.estimatedHours,
    required this.tags,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      assignee: json['assignee'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      priority: json['priority'] as String,
      status: json['status'] as String,
      category: json['category'] as String,
      estimatedHours: json['estimatedHours'] as int,
      tags: List<String>.from(json['tags'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'assignee': assignee,
      'dueDate': dueDate.toIso8601String(),
      'priority': priority,
      'status': status,
      'category': category,
      'estimatedHours': estimatedHours,
      'tags': tags,
    };
  }
}