import 'package:flutter/material.dart';

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
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF17212B),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF233040),
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF233040),
          selectedItemColor: Color(0xFF64B5F6),
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
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ChatListScreen(),
    const Center(child: Text("Contacts Screen", style: TextStyle(fontSize: 24))),
    const Center(child: Text("Settings Screen", style: TextStyle(fontSize: 24))),
    const Center(child: Text("Personal Screen", style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: 'Contacts'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Personal'),
        ],
      ),
      body: _screens[_selectedIndex],
    );
  }
}

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Opening chat with ${chat['name']}...")));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF4FA9F3),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}
