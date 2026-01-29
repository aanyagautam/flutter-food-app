class Child {
  final String name;
  final String className;
  final String rollNo;
  final String schoolId;

  Child({
    required this.name,
    required this.className,
    required this.rollNo,
    required this.schoolId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'className': className,
      'rollNo': rollNo,
      'schoolId': schoolId,
    };
  }

  factory Child.fromMap(Map<String, dynamic> map) {
    return Child(
      name: map['name'] ?? '',
      className: map['className'] ?? '',
      rollNo: map['rollNo'] ?? '',
      schoolId: map['schoolId'] ?? '',
    );
  }
}
