// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String id;
  final String email;
  final String name;
  final int? department;
  final String employee_id;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.department,
    required this.employee_id,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      email: data['email'],
      name: data['name'],
      department: data['department'],
      employee_id: data['employee_id'] ?? '',
    );
  }
}
