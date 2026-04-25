import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

// ==========================================
// 1. MAIN APP ENTRY (التشغيل والسمة الجلاسية)
// ==========================================
void main() {
  runApp(const Telegram2026UltimateApp());
}

class Telegram2026UltimateApp extends StatelessWidget {
  const Telegram2026UltimateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telegram 2026 (Glassy Ultimate)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F1722), // خلفية داكنة جداً لدعم الزجاج
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: const MainGlassyNavigation(),
    );
  }
}

// ==========================================
// 2. MAIN NAVIGATION (الهيكل الأساسي والزجاج السفلي)
// ==========================================
class MainGlassyNavigation extends StatefulWidget {
  const MainGlassyNavigation({super.key});

  @override
  State<MainGlassyNavigation> createState() => _MainGlassyNavigationState();
}

class _MainGlassyNavigationState extends State<MainGlassyNavigation> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    const ChatListScreen(),
    const BotsAndMiniAppsScreen(), // شاشة البوتات والتطبيقات المصغرة (2026)
    const ContactsScreen(),
    const SettingsGlassyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // خلفية حية (Gradient Animation) لإبراز تأثير الزجاج
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0B1014), Color(0xFF1C2D42)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // الشاشة الحالية
          IndexedStack(index: _currentIndex, children: _screens),
          
          // الشريط السفلي الزجاجي (Glassmorphism)
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(Icons.chat_bubble_rounded, "Chats", 0),
                      _buildNavItem(Icons.smart_toy_rounded, "Bots", 1),
                      _buildNavItem(Icons.people_alt_rounded, "Contacts", 2),
                      _buildNavItem(Icons.settings_rounded, "Settings", 3),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? Colors.blueAccent : Colors.grey, size: 26),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: isSelected ? Colors.blueAccent : Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. CHAT LIST SCREEN (قائمة الدردشات + القصص)
// ==========================================
class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<User> dummyChats = [
      User(id: '1', name: 'Server Global', avatar: 'S', isOnline: true, lastMessage: 'مرحباً بك في سيرفر 2026'),
      User(id: '2', name: 'AI Assistant', avatar: '🤖', isOnline: true, lastMessage: 'تم تحليل البيانات بنجاح.'),
      User(id: '3', name: 'Elon Musk', avatar: 'E', isOnline: false, lastMessage: 'What about the new rockets?'),
    ];

    return SafeArea(
      child: Column(
        children: [
          // شريط القصص (Stories 2026)
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [Colors.blue, Colors.purple])),
                        child: CircleAvatar(radius: 26, backgroundColor: Colors.grey[900], child: Text("U$index")),
                      ),
                      const SizedBox(height: 5),
                      Text("User $index", style: const TextStyle(color: Colors.white, fontSize: 10)),
                    ],
                  ),
                );
              },
            ),
          ),
          // قائمة الدردشات
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 90),
              itemCount: dummyChats.length,
              separatorBuilder: (_, __) => Divider(color: Colors.white.withOpacity(0.05), indent: 80),
              itemBuilder: (context, index) {
                final chat = dummyChats[index];
                return ListTile(
                  leading: CircleAvatar(radius: 28, backgroundColor: Colors.blueAccent.withOpacity(0.5), child: Text(chat.avatar, style: const TextStyle(fontSize: 20))),
                  title: Text(chat.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  subtitle: Text(chat.lastMessage, style: const TextStyle(color: Colors.grey), maxLines: 1),
                  trailing: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("12:00 PM", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      SizedBox(height: 5),
                      CircleAvatar(radius: 10, backgroundColor: Colors.blueAccent, child: Text("2", style: TextStyle(fontSize: 10))),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ActiveChatScreen(user: chat)));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 4. ACTIVE CHAT SCREEN (الشات الحقيقي المتصل بالسيرفر)
// ==========================================
class ActiveChatScreen extends StatefulWidget {
  final User user;
  const ActiveChatScreen({super.key, required this.user});

  @override
  State<ActiveChatScreen> createState() => _ActiveChatScreenState();
}

class _ActiveChatScreenState extends State<ActiveChatScreen> {
  late WebSocketChannel channel;
  List<Message> messages = [];
  final String myDeviceId = const Uuid().v4();
  final TextEditingController _msgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // الاتصال بالسيرفر بتاعك
    channel = WebSocketChannel.connect(Uri.parse('wss://services-lau3jg.fly.dev/ws/chat'));
    channel.stream.listen((data) {
      String msgText = data.toString();
      if (msgText.startsWith(myDeviceId)) return;
      setState(() {
        messages.add(Message(id: const Uuid().v4(), text: msgText.replaceFirst(myDeviceId, ''), isMe: false, time: DateTime.now()));
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    _msgController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_msgController.text.trim().isEmpty) return;
    String text = _msgController.text;
    channel.sink.add('$myDeviceId$text');
    setState(() {
      messages.add(Message(id: const Uuid().v4(), text: text, isMe: true, time: DateTime.now()));
    });
    _msgController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AppBar(
              backgroundColor: const Color(0xFF17212B).withOpacity(0.5),
              title: Row(
                children: [
                  CircleAvatar(radius: 18, backgroundColor: Colors.blueAccent, child: Text(widget.user.avatar)),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.user.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(widget.user.isOnline ? "Online" : "Last seen recently", style: const TextStyle(fontSize: 12, color: Colors.blueAccent)),
                    ],
                  ),
                ],
              ),
              actions: [
                IconButton(icon: const Icon(Icons.videocam_outlined), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CallGlassyScreen()))),
                IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i.pinimg.com/736x/8c/98/99/8c98994518b575bfd8c949e91d20548b.jpg'), // خلفية شات تيليجرام
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: false,
                padding: const EdgeInsets.only(top: 100, bottom: 20),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  return Align(
                    alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: msg.isMe ? const Color(0xFF4FA9F3).withOpacity(0.8) : const Color(0xFF233040).withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(15),
                          topRight: const Radius.circular(15),
                          bottomLeft: Radius.circular(msg.isMe ? 15 : 0),
                          bottomRight: Radius.circular(msg.isMe ? 0 : 15),
                        ),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(msg.text, style: const TextStyle(color: Colors.white, fontSize: 16)),
                          const SizedBox(height: 5),
                          Text(DateFormat('hh:mm a').format(msg.time), style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 10)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Glassy Input Bar
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: const Color(0xFF17212B).withOpacity(0.6),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      children: [
                        IconButton(icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.grey), onPressed: () {}),
                        Expanded(
                          child: TextField(
                            controller: _msgController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: "Message...",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(icon: const Icon(Icons.attach_file, color: Colors.grey), onPressed: () {}),
                        Container(
                          decoration: const BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle),
                          child: IconButton(icon: const Icon(Icons.send, color: Colors.white, size: 20), onPressed: _sendMessage),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 5. CALL SCREEN (المكالمات الفضائية بالزجاج - نسخة الاحتراف)
// ==========================================
class CallGlassyScreen extends StatelessWidget {
  const CallGlassyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // خلفية المكالمة (صورة افتراضية)
          Image.network('https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=800', fit: BoxFit.cover, height: double.infinity, width: double.infinity),
          // زر الرجوع
          Positioned(top: 50, left: 20, child: IconButton(icon: const Icon(Icons.keyboard_arrow_down, size: 35, color: Colors.white), onPressed: () => Navigator.pop(context))),
          
          // أيقونات الـ 2026
          const Positioned(
            top: 60, right: 20,
            child: Row(
              children: [
                Icon(Icons.view_in_ar, color: Colors.blueAccent), SizedBox(width: 10),
                Icon(Icons.spatial_audio_off, color: Colors.white),
              ],
            ),
          ),

          // لوحة التحكم السفلية الجلاسية
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.only(top: 30, bottom: 50),
                  color: Colors.white.withOpacity(0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCallBtn(Icons.flip_camera_ios, Colors.white24),
                      _buildCallBtn(Icons.videocam_outlined, Colors.white24),
                      _buildCallBtn(Icons.mic_none, Colors.white24),
                      _buildCallBtn(Icons.call_end, Colors.redAccent),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallBtn(IconData icon, Color bg) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.1))),
      child: Icon(icon, color: Colors.white, size: 30),
    );
  }
}

// ==========================================
// 6. BOTS & MINI APPS SCREEN (ويب 3 و تطبيقات مصغرة 2026)
// ==========================================
class BotsAndMiniAppsScreen extends StatelessWidget {
  const BotsAndMiniAppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Mini Apps & Web3", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _buildMiniAppCard(Icons.account_balance_wallet, "TON Wallet", Colors.blue),
                  _buildMiniAppCard(Icons.gamepad, "GameFi Hub", Colors.purple),
                  _buildMiniAppCard(Icons.auto_awesome, "AI Creator", Colors.orange),
                  _buildMiniAppCard(Icons.shopping_cart, "Crypto Store", Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniAppCard(IconData icon, String title, Color color) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(color: color.withOpacity(0.1), border: Border.all(color: color.withOpacity(0.3))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: color),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 7. SETTINGS SCREEN (الإعدادات الجلاسية)
// ==========================================
class SettingsGlassyScreen extends StatelessWidget {
  const SettingsGlassyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Center(
            child: CircleAvatar(radius: 50, backgroundColor: Colors.blueAccent, child: Icon(Icons.person, size: 50, color: Colors.white)),
          ),
          const SizedBox(height: 15),
          const Center(child: Text("Eng. Qatar", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
          const Center(child: Text("+20 100 000 0000", style: TextStyle(color: Colors.grey, fontSize: 14))),
          const SizedBox(height: 40),
          _buildSettingsTile(Icons.data_usage, "Data and Storage"),
          _buildSettingsTile(Icons.lock_outline, "Privacy and Security"),
          _buildSettingsTile(Icons.color_lens_outlined, "Appearance (Glass Theme)"),
          _buildSettingsTile(Icons.language, "Language"),
          _buildSettingsTile(Icons.help_outline, "Telegram FAQ"),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white.withOpacity(0.05))),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      ),
    );
  }
}

// ==========================================
// 8. CONTACTS SCREEN (قائمة جهات الاتصال)
// ==========================================
class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Contacts Synced via API...", style: TextStyle(color: Colors.grey)));
  }
}

// ==========================================
// 9. DATA MODELS (نماذج البيانات)
// ==========================================
class User {
  final String id;
  final String name;
  final String avatar;
  final bool isOnline;
  final String lastMessage;

  User({required this.id, required this.name, required this.avatar, this.isOnline = false, this.lastMessage = ''});
}

class Message {
  final String id;
  final String text;
  final bool isMe;
  final DateTime time;

  Message({required this.id, required this.text, required this.isMe, required this.time});
}
