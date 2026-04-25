import 'package:flutter/material.dart';
import 'package:repo_app/models/message.dart';
import 'package:repo_app/models/user.dart';
import 'package:repo_app/widgets/input_bar.dart';
import 'package:repo_app/widgets/message_bubble.dart';
import 'package:repo_app/screens/call_screen.dart';
import 'package:repo_app/screens/group_profile_screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart'; // مكتبة السيرفر
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  final User user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late WebSocketChannel channel;
  List<Message> messages = [];
  final String myDeviceId = const Uuid().v4(); // كود سري لجهازك

  @override
  void initState() {
    super.initState();
    // 🚀 الاتصال بالسيرفر الوحش بتاعك
    channel = WebSocketChannel.connect(
      Uri.parse('wss://services-lau3jg.fly.dev/ws/chat'),
    );

    // 📥 استقبال الرسايل من السيرفر
    channel.stream.listen((data) {
      String msgText = data.toString();
      
      // عشان السيرفر بيبعت الرسالة للكل، بنتأكد إنها مش رسالتنا اللي لسه باعتينها
      if (msgText.startsWith(myDeviceId)) return;

      setState(() {
        messages.add(Message(
          id: const Uuid().v4(),
          senderId: 'remote',
          text: msgText.replaceFirst('remote:', ''), // تنظيف النص
          type: MessageType.text,
          date: DateTime.now(),
          isMyMessage: false,
        ));
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  // 📤 إرسال رسالة للسيرفر
  void _sendMessage(String text) {
    // إرسال للسيرفر
    channel.sink.add('$myDeviceId$text'); 

    // إظهار الرسالة عندي في الشاشة فوراً
    setState(() {
      messages.add(Message(
        id: const Uuid().v4(),
        senderId: 'me',
        text: text,
        type: MessageType.text,
        date: DateTime.now(),
        isMyMessage: true,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17212B),
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueGrey[700],
              radius: 20,
              child: Text(widget.user.name[0], style: const TextStyle(color: Colors.white, fontSize: 16)),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.user.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                Text(widget.user.isOnline ? "online" : "last seen", style: const TextStyle(color: Colors.grey, fontSize: 12)),
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => GroupProfileScreen(user: widget.user)));
          }),
          const SizedBox(width: 5),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 20, top: 20),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return MessageBubble(message: messages[index]);
        },
      ),
      // ربط شريط الإدخال بوظيفة الإرسال
      bottomNavigationBar: InputBar(onSend: _sendMessage),
    );
  }
}
