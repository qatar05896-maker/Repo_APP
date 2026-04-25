import 'package:flutter/material.dart';
import 'package:repo_app/models/user.dart';

class GroupProfileScreen extends StatelessWidget {
  final User user;

  const GroupProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // بيانات وهمية للأعضاء
    final List<User> dummyMembers = [
      User(id: '1', name: "Abdullah M", avatarUrl: "assets/images/user1.png", role: UserRole.owner, isOnline: true),
      User(id: '2', name: "Aavya Music", avatarUrl: "assets/images/user1.png", role: UserRole.admin, lastSeen: DateTime.now().subtract(const Duration(minutes: 2))),
      User(id: '3', name: "Ahmed Masud", avatarUrl: "assets/images/user1.png", role: UserRole.admin, lastSeen: DateTime.now().subtract(const Duration(hours: 3))),
      User(id: '4', name: "Me", avatarUrl: "assets/images/user1.png", role: UserRole.admin, lastSeen: DateTime.now().subtract(const Duration(days: 1))),
      User(id: '5', name: "Arwa", avatarUrl: "assets/images/user1.png", lastSeen: DateTime.now().subtract(const Duration(days: 2))),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF17212B), // لون خلفية تيليجرام الأصلي
      // 1. شريط تطبيقات (AppBar) مع صورة خلفية دائرية كبيرة زي الصورة 3
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueGrey[700],
              radius: 20,
              child: Text(user.name[0], style: const TextStyle(color: Colors.white, fontSize: 16)),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                const Text("24 members", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ],
        ),
        actions: const [
          Icon(Icons.edit, color: Colors.grey),
          SizedBox(width: 10),
          Icon(Icons.more_vert),
          SizedBox(width: 10),
        ],
      ),
      // 2. بناء القائمة الرئيسية (ListView) زي الصورة 3
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF17212B), // لون خلفية تيليجرام الأصلي
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueGrey[700],
                  radius: 70,
                  child: Text(user.name[0], style: const TextStyle(color: Colors.white, fontSize: 64)),
                ),
                const SizedBox(height: 16),
                Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white)),
                const Text("24 members", style: TextStyle(color: Colors.grey, fontSize: 16)),
                const SizedBox(height: 16),
                // 3. قسم أزرار عمل أفقي سريع (Message, Mute, Voice Chat, Leave) زي الصورة 3
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(icon: const Icon(Icons.chat_bubble_outline), color: Colors.white, onPressed: () {}),
                    IconButton(icon: const Icon(Icons.volume_off), color: Colors.white, onPressed: () {}),
                    IconButton(icon: const Icon(Icons.voicemail), color: Colors.white, onPressed: () {}),
                    IconButton(icon: const Icon(Icons.leave_bags_at_home), color: Colors.red, onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
          // 4. بناء قسم الأعضاء المقسمة حسب الأدوار (المالك، مشرف) مع أيقونات "الحالة" (online) زي الصورة 3
          ListView.separated(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            itemCount: dummyMembers.length,
            separatorBuilder: (context, index) => const Divider(color: Color(0xFF2B394A), height: 1),
            itemBuilder: (context, index) {
              final member = dummyMembers[index];
              return ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: CircleAvatar(
                  backgroundColor: Colors.blueGrey[700],
                  radius: 24,
                  child: Text(member.name[0], style: const TextStyle(color: Colors.white, fontSize: 18)),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(member.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                    // أيقونة "الحالة" (online) زي الصورة 3
                    if (member.isOnline) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.circle, color: Color(0xFF64B5F6), size: 10),
                    ],
                  ],
                ),
                subtitle: Text(
                  member.isOnline ? "online" : "last seen ${member.lastSeen}",
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                trailing: Text(
                  member.role == UserRole.owner ? "المالك" : (member.role == UserRole.admin ? "مشرف" : "عضو"),
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
