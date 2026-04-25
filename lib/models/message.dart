enum MessageType { text, image, video, audio, call }

class Message {
  final String id;
  final String senderId;
  final String text;
  final MessageType type;
  final DateTime date;
  final bool isMyMessage;
  final String? mediaUrl; // مسار ملف الميديا (صورة، فيديو، موسيقى)
  final String? audioTitle;
  final String? audioAuthor;
  final Duration? duration; // مدة المكالمة أو الصوت
  final List<String>? inlineButtons; // أزرار متصلة بالرسالة

  Message({
    required this.id,
    required this.senderId,
    this.text = '',
    required this.type,
    required this.date,
    required this.isMyMessage,
    this.mediaUrl,
    this.audioTitle,
    this.audioAuthor,
    this.duration,
    this.inlineButtons,
  });
}
