import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart'; // مكتبة الأيقونات اللي أضفناها

void main() {
  runApp(const TelegramCloneApp());
}

class TelegramCloneApp extends StatelessWidget {
  const TelegramCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telegram 2026',
      debugShowCheckedModeBanner: false,
      // 1. تفعيل الوضع الغامق (Dark Mode) زي الصور
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
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // للتحكم في التبويب الحالي

  // 2. محتويات التبويبات السفليّة (عينة تجريبية)
  final List<Widget> _screens = [
    const ChatListScreen(), // شاشة المحادثات الرئيسية
    const Center(child: Text("Contacts Screen", style: TextStyle(fontSize: 24))),
    const Center(child: Text("Settings Screen", style: TextStyle(fontSize: 24))),
    const Center(child: Text("Personal Screen", style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 3. تركيب الشريط السفلي (Bottom Navigation) زي الصورة 2
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed, // عشان يظهر النص والأيقونة
        items: const [
          BottomNavigationBarItem(icon: Icon(Ionicons.chatbubble_ellipses), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Ionicons.people), label: 'Contacts'),
          BottomNavigationBarItem(icon: Icon(Ionicons.settings), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Ionicons.person_circle), label: 'Personal'),
        ],
      ),
      body: _screens[_selectedIndex],
        );
  }
}

// شاشة قائمة الدردشات (تصميم يحاكي الصورة 2)
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // بيانات وهمية للعرض فقط
    final List<Map<String, String>> dummyChats = [
      {"name": "Telegram", "msg": "Hello! Welcome to...", "time": "2:04 PM", "unread": "155"},
      {"name": "Ehab TV", "msg": "هذا قبل التحديث", "time": "2:01 PM", "unread": "4"},
      {"name": "Shop Crowns", "msg": "new offers!", "time": "1:38 PM", "unread": "1"},
      {"name": "Arwa", "msg": "You have pushed the button...", "time": "Yesterday", "unread": "0"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Telegram", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        leading: const Icon(Icons.menu),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 15),
          Icon(Icons.more_vert),
          SizedBox(width: 10),
        ],
      ),
      // 4. بناء القائمة الرئيسية (ListView) زي الصورة 2
      body: ListView.separated(
        itemCount: dummyChats.length,
        separatorBuilder: (context, index) => const Divider(color: Color(0xFF2B394A), height: 1),
        itemBuilder: (context, index) {
          final chat = dummyChats[index];
          final hasUnread = chat['unread'] != "0";
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey[700],
              radius: 28,
              child: Text(chat['name']![0], style: const TextStyle(color: Colors.white, fontSize: 20)),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(chat['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white)),
                Text(chat['time']!, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(chat['msg']!, style: const TextStyle(color: Colors.grey, fontSize: 15), maxLines: 1, overflow: TextOverflow.ellipsis)),
                if (hasUnread)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Color(0xFF4FA9F3), shape: BoxShape.circle),
                    child: Text(chat['unread']!, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
            onTap: () {
              // هنا هنفتح شاشة الشات اللي جوه بعدين
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Opening chat with ${chat['name']}...")));
            },
          );
        },
      ),
      // 5. زر الإرسال الطائر الأزرق زي الصورة 2
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF4FA9F3),
        child: const Icon(Icons.add_comment, color: Colors.white),
      ),
    );
  }
}
