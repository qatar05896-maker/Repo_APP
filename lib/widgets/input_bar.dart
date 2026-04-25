import 'package:flutter/material.dart';

class InputBar extends StatefulWidget {
  const InputBar({super.key});

  @override
  State<InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<InputBar> {
  final TextEditingController _controller = TextEditingController(); // للتحكم في النص المدخل

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: const Color(0xFF233040), // لون شريط تيليجرام السفلي
      child: Row(
        children: [
          // أيقونة الرموز التعبيرية
          IconButton(icon: const Icon(Icons.sentiment_satisfied_alt_outlined), color: Colors.grey, onPressed: () {}),
          const SizedBox(width: 8),
          // حقل إدخال النص المخصص
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Message",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white, fontSize: 16),
              onChanged: (text) {
                // هنا هنبرمج وظيفة إظهار زر الإرسال بعدين
              },
            ),
          ),
          const SizedBox(width: 8),
          // أيقونة المرفقات (clip)
          IconButton(icon: const Icon(Icons.attach_file), color: Colors.grey, onPressed: () {}),
          const SizedBox(width: 8),
          // أيقونة الميكروفون/الإرسال
          IconButton(icon: const Icon(Icons.mic_none_outlined), color: const Color(0xFF4FA9F3), onPressed: () {
            // هنا هنبرمج وظيفة الإرسال بعدين
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sending message: ${_controller.text}...")));
            _controller.clear(); // مسح النص بعد الإرسال
          }),
        ],
      ),
    );
  }
}
