import 'package:flutter/material.dart';
import 'package:repo_app/models/message.dart';
import 'package:repo_app/models/user.dart';
import 'package:repo_app/widgets/input_bar.dart';
import 'package:repo_app/widgets/message_bubble.dart';
// أضفنا استيراد الشاشات هنا 👇
import 'package:repo_app/screens/call_screen.dart';
import 'package:repo_app/screens/group_profile_screen.dart';

class ChatScreen extends StatelessWidget {
  final User user;

  const ChatScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final List<Message> dummyMessages = [
      Message(id: '1', senderId: 'user1', text: "Hello! Welcome to repo_app!", type: MessageType.text, date: DateTime.now().subtract(const Duration(minutes: 1)), isMyMessage: false),
      Message(id: '2', senderId: 'user1', text: "this is image...", type: MessageType.image, date: DateTime.now().subtract(const Duration(minutes: 1)), isMyMessage: false, mediaUrl: user.avatarUrl),
      Message(id: '3', senderId: 'repo_app', text: "تشغيل اتنسينا", type: MessageType.text, date: DateTime.now(), isMyMessage: true),
      Message(id: '4', senderId: 'repo_app', type: MessageType.audio, date: DateTime.now(), isMyMessage: true, audioTitle: "Youssif Elashry - Etnse", audioAuthor: "Abdullah M", inlineButtons: ["OWNER", "CHANNEL", "إغلاق"]),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF17212B),
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
                Text(user.isOnline ? "online" : "last seen", style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.videocam), color: Colors.grey, onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CallScreen()));
          }),
          const SizedBox(width: 10),
          IconButton(icon: const Icon(Icons.more_vert), color: Colors.grey, onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => GroupProfileScreen(user: user)));
          }),
          const SizedBox(width: 5),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 80, top: 60),
            itemCount: dummyMessages.length,
            itemBuilder: (context, index) {
              final message = dummyMessages[index];
              return MessageBubble(message: message);
            },
          ),
          // شيلنا كلمة const من هنا 👇
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: const Color(0xFF233040), borderRadius: BorderRadius.circular(12)),
              child: const Row(
                children: [
                  Icon(Icons.push_pin, color: Color(0xFF64B5F6), size: 16),
                  SizedBox(width: 8),
                  Text("Pinned Message", style: TextStyle(color: Color(0xFF64B5F6), fontSize: 15)),
                  SizedBox(width: 8),
                  Text("Hello! Welcome to repo_app!", style: TextStyle(color: Colors.grey, fontSize: 13)),
                  Spacer(),
                  Icon(Icons.close, color: Colors.grey, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const InputBar(),
    );
  }
}
