class StudentFromApiCall {
  final String? id;
  final String? name;
  final String? email;
  final String? enrolmentStatus;
  final String? imageUrl;

  StudentFromApiCall({
    this.id,
    this.name,
    this.email,
    this.enrolmentStatus,
    this.imageUrl,
  });

  // Factory method to create a Student instance from JSON
  factory StudentFromApiCall.fromJson(Map<String, dynamic> json) {
    return StudentFromApiCall(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      enrolmentStatus: json['enrolmentStatus'],
      imageUrl: json['imageUrl'],
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
