import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:repo_app/models/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // تحديد لون وحواف الفقاعة بناءً على نوع الرسالة ومن أرسلها
    final Color bubbleColor = message.isMyMessage
        ? const Color(0xFF32486A) // لون فقاعة رسائلي (أرجواني غامق)
        : const Color(0xFF2B394A); // لون فقاعة رسائلهم (رمادي غامق)

    final BorderRadius borderRadius = message.isMyMessage
        ? const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(4),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(16),
          );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      alignment: message.isMyMessage ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: bubbleColor, borderRadius: borderRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عرض محتوى الرسالة بناءً على نوعها (نص، صورة، فيديو، موسيقى)
            _buildMessageContent(context),
            const SizedBox(height: 8),
            // عرض وقت الرسالة وعلامة الصح (وهمية)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat.jm().format(message.date),
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
                if (message.isMyMessage) ...[
                  const SizedBox(width: 4),
                  const Icon(Icons.done, color: Color(0xFF64B5F6), size: 14),
                ],
              ],
            ),
            // عرض الأزرار المضمنة (الانلاين) إذا وجدت
            if (message.inlineButtons != null) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: message.inlineButtons!.map((buttonText) => ActionChip(
                  label: Text(buttonText, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  backgroundColor: const Color(0xFF2B394A),
                  onPressed: () {
                    // هنا هنبرمج وظيفة الزر بعدين
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pressed $buttonText...")));
                  },
                )).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMessageContent(BuildContext context) {
    switch (message.type) {
      case MessageType.text:
        return Text(message.text, style: const TextStyle(color: Colors.white, fontSize: 16));
      case MessageType.image:
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(message.mediaUrl!, fit: BoxFit.cover),
        );
      case MessageType.video:
        // هنا هنعرض فيديو لاعب (وهمي)
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: Colors.black,
            child: const Center(child: Icon(Icons.play_circle_filled, color: Colors.white, size: 48)),
          ),
        );
      case MessageType.audio:
        // هنا هنعرض فقاعة تشغيل الموسيقى/الفيديو الغنية (مثل الصورة 4)
        return Container(
          decoration: BoxDecoration(color: const Color(0xFF17212B), borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("بدأ التشغيل", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("${message.audioTitle} - ${message.audioAuthor}", style: const TextStyle(color: Color(0xFF64B5F6), fontSize: 16)),
              const SizedBox(height: 8),
              // شريط تقدم تشغيل الصوت (وهمي)
              LinearProgressIndicator(value: 0.5, backgroundColor: Colors.blueGrey[700], valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF64B5F6))),
              const SizedBox(height: 8),
              // أزرار تحكم الموسيقى (وهمية)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("02:25", style: TextStyle(color: Colors.grey, fontSize: 13)),
                  IconButton(icon: const Icon(Icons.play_arrow), color: Colors.white, onPressed: () {}),
                  const Text("2:28", style: TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
            ],
          ),
        );
      case MessageType.call:
        return Row(
          children: [
            const Icon(Icons.call_made, color: Color(0xFF64B5F6), size: 16),
            const SizedBox(width: 8),
            const Text("مكالمة صادرة", style: TextStyle(color: Colors.white, fontSize: 15)),
            const SizedBox(width: 8),
            Text(DateFormat.jm().format(message.date), style: const TextStyle(color: Colors.grey, fontSize: 11)),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
