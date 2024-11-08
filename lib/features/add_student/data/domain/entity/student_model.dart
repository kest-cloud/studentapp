class Student {
  final int? id;
  final String? name;
  final String? email;
  final String? enrolmentStatus;
  final String? imageUrl;

  Student({
    this.id,
    this.name,
    this.email,
    this.enrolmentStatus,
    this.imageUrl,
  });

  // Factory method to create a Student instance from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      enrolmentStatus: json['enrolmentStatus'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  // Method to convert a Student instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'enrolmentStatus': enrolmentStatus,
      'imageUrl': imageUrl,
    };
  }
}
