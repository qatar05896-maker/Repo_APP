enum UserRole { owner, admin, member }

class User {
  final String id;
  final String name;
  final String avatarUrl; // مسار صورة الملف الشخصي
  final UserRole role;
  final DateTime? lastSeen;
  final bool isOnline;

  User({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.role = UserRole.member,
    this.lastSeen,
    this.isOnline = false,
  });
}
