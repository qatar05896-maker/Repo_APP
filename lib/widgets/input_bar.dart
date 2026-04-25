import 'package:flutter/material.dart';

class InputBar extends StatefulWidget {
  final Function(String) onSend; // وظيفة الإرسال اللي هنستقبلها

  const InputBar({super.key, required this.onSend});

  @override
  State<InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<InputBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: const Color(0xFF233040),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.sentiment_satisfied_alt_outlined), color: Colors.grey, onPressed: () {}),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Message",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(icon: const Icon(Icons.attach_file), color: Colors.grey, onPressed: () {}),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send), // غيرنا الأيقونة لزرار إرسال
            color: const Color(0xFF4FA9F3), 
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                widget.onSend(_controller.text); // إرسال النص
                _controller.clear(); // مسح المربع
              }
            }
          ),
        ],
      ),
    );
  }
}
