class Flag {
  final String id;
  final String title;
  final String description;
  final String severity;
  final DateTime createdAt;
  final String status;
  final String category;

  Flag({
    required this.id,
    required this.title,
    required this.description,
    required this.severity,
    required this.createdAt,
    required this.status,
    required this.category,
  });

  factory Flag.fromJson(Map<String, dynamic> json) {
    return Flag(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      severity: json['severity'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String,
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'severity': severity,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'category': category,
    };
  }
}