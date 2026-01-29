class SchoolUser {
  final String id;
  final String parentName;
  final String phone;
  final String email;
  final String childName;
  final String childClass;
  final String childRollNo;
  final String schoolId;
  final bool isTeacher;
  final DateTime createdAt;

  SchoolUser({
    required this.id,
    required this.parentName,
    required this.phone,
    required this.email,
    required this.childName,
    required this.childClass,
    required this.childRollNo,
    required this.schoolId,
    this.isTeacher = false,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'parentName': parentName,
      'phone': phone,
      'email': email,
      'childName': childName,
      'childClass': childClass,
      'childRollNo': childRollNo,
      'schoolId': schoolId,
      'isTeacher': isTeacher,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory SchoolUser.fromMap(Map<String, dynamic> map) {
    return SchoolUser(
      id: map['id'] ?? '',
      parentName: map['parentName'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      childName: map['childName'] ?? '',
      childClass: map['childClass'] ?? '',
      childRollNo: map['childRollNo'] ?? '',
      schoolId: map['schoolId'] ?? '',
      isTeacher: map['isTeacher'] ?? false,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
    );
  }

  SchoolUser copyWith({
    String? id,
    String? parentName,
    String? phone,
    String? email,
    String? childName,
    String? childClass,
    String? childRollNo,
    String? schoolId,
    bool? isTeacher,
    DateTime? createdAt,
  }) {
    return SchoolUser(
      id: id ?? this.id,
      parentName: parentName ?? this.parentName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      childName: childName ?? this.childName,
      childClass: childClass ?? this.childClass,
      childRollNo: childRollNo ?? this.childRollNo,
      schoolId: schoolId ?? this.schoolId,
      isTeacher: isTeacher ?? this.isTeacher,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
