import 'package:flutter/material.dart';
import 'package:repo_app/models/user.dart';
import 'package:repo_app/screens/chat_screen.dart';

void main() {
  runApp(const TelegramCloneApp());
}

class TelegramCloneApp extends StatelessWidget {
  const TelegramCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    // بيانات وهمية لمستخدم الدردشة
    final User dummyUser = User(id: '1', name: "Telegram", avatarUrl: "assets/images/user1.png", isOnline: true);

    return MaterialApp(
      title: 'Telegram 2026',
      debugShowCheckedModeBanner: false,
      // 1. تحديد سمة داكنة (Dark Theme) زي الصور
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF17212B), // لون خلفية تيليجرام الأصلي
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF233040), // لون شريط تيليجرام العلوي
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF233040),
          selectedItemColor: Color(0xFF64B5F6), // لون أزرق تيليجرام عند الاختيار
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: ChatScreen(user: dummyUser), // فتح شاشة المحادثة التجريبية
    );
  }
}
