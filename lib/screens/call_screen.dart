import 'package:flutter/material.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17212B), // لون خلفية تيليجرام الأصلي
      // 1. بناء شاشة مكالمات الفيديو الوهمية زي الصورة 4
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 80)),
            CircleAvatar(
              backgroundColor: Colors.blueGrey[700],
              radius: 64,
              child: const Text("T", style: TextStyle(color: Colors.white, fontSize: 64)),
            ),
            const SizedBox(height: 16),
            const Text("Telegram", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white)),
            const Text("Calling...", style: TextStyle(color: Colors.grey, fontSize: 16)),
            const Spacer(),
            // 2. أزرار تحكم مكالمة الفيديو الوهمية زي الصورة 4
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(icon: const Icon(Icons.mic_none), color: Colors.white, onPressed: () {}),
                IconButton(icon: const Icon(Icons.videocam_none), color: Colors.white, onPressed: () {}),
                IconButton(icon: const Icon(Icons.call_end), color: Colors.red, onPressed: () {}),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 80)),
          ],
        ),
      ),
    );
  }
}
