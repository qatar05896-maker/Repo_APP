import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  // === حالات المكالمة الأساسية ===
  bool _isMuted = false;
  bool _isVideoOn = true;
  bool _isFrontCamera = true;
  bool _isSpeakerOn = true;

  // === الميزات المتقدمة (2026) ===
  bool _noiseCancellationEnabled = false; // تقليل التشويش (AI Denoise)
  bool _spatialAudioEnabled = false; // الصوت المحيطي (Dolby Atmos/Spatial)
  bool _glassModeEnabled = false; // وضع النظارات الذكية (AR/Smart Glasses)
  String _audioRouting = "Stereo"; // مسار الصوت (Mono, Stereo, Surround)

  // === إدارة وقت المكالمة ===
  Timer? _timer;
  int _secondsElapsed = 0;

  // === التحكم في الكاميرا المصغرة العائمة (PIP) ===
  double _pipX = 20;
  double _pipY = 100;

  @override
  void initState() {
    super.initState();
    _startTimer();
    // هنا مستقبلاً بيتم تهيئة مكتبة WebRTC أو Agora
  }

  @override
  void dispose() {
    _timer?.cancel();
    // هنا بيتم إغلاق الكاميرا والمايك
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  String _formatDuration(int seconds) {
    final int min = seconds ~/ 60;
    final int sec = seconds % 60;
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. الخلفية: فيديو الشخص الآخر (أو صورة ضبابية لو الكاميرا مقفولة)
          _buildRemoteVideo(),

          // 2. شريط الحالة العلوي (التشفير، الوقت، وضع النظارة)
          _buildTopBar(),

          // 3. الكاميرا المحلية العائمة (PIP) قابلة للسحب
          if (_isVideoOn) _buildDraggableLocalVideo(screenSize),

          // 4. لوحة التحكم السفلية (زجاجية عصرية)
          _buildBottomControlPanel(),
        ],
      ),
    );
  }

  // === بناء المكونات (Widgets) ===

  Widget _buildRemoteVideo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1C2833), Color(0xFF0E151C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // لو في فيديو حقيقي هيتحط هنا (RTCVideoView)
          // حالياً هنعرض صورة وهمية ضبابية
          Image.network(
            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // تأثير تعتيم خفيف على الصورة
          Container(color: Colors.black.withOpacity(0.3)),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // زر الرجوع / تصغير المكالمة
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 32),
            onPressed: () => Navigator.pop(context),
          ),
          // معلومات المكالمة (تشفير + وقت)
          Column(
            children: [
              Row(
                children: const [
                  Icon(Icons.lock, color: Colors.greenAccent, size: 14),
                  SizedBox(width: 6),
                  Text("End-to-End Encrypted", style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                _formatDuration(_secondsElapsed),
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
            ],
          ),
          // مؤشر وضع النظارة الذكية (Glass Mode)
          GestureDetector(
            onTap: () {
              setState(() => _glassModeEnabled = !_glassModeEnabled);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_glassModeEnabled ? "Smart Glass Mode Activated" : "Glass Mode Disabled")));
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _glassModeEnabled ? Colors.blueAccent.withOpacity(0.4) : Colors.black45,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.glasses, color: _glassModeEnabled ? Colors.blueAccent : Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableLocalVideo(Size screenSize) {
    return Positioned(
      left: _pipX,
      top: _pipY,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _pipX += details.delta.dx;
            _pipY += details.delta.dy;
            // حماية الكاميرا من الخروج بره الشاشة
            _pipX = _pipX.clamp(0.0, screenSize.width - 120.0);
            _pipY = _pipY.clamp(40.0, screenSize.height - 300.0);
          });
        },
        child: Container(
          width: 110,
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, spreadRadius: 2)],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            // هنا بيتحط فيديو الكاميرا الأمامية بتاعك
            child: Container(
              color: Colors.blueGrey[900],
              child: const Center(child: Icon(Icons.person, color: Colors.white54, size: 50)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControlPanel() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15), // تأثير الزجاج (Frosted Glass)
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20, bottom: 40, left: 20, right: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF17212B).withOpacity(0.7),
              border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. شريط الميزات المتقدمة (Advanced Audio Features)
                _buildAdvancedAudioControls(),
                
                const SizedBox(height: 25),
                
                // 2. أزرار التحكم الأساسية (مايك، كاميرا، سماعة، إنهاء)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildControlButton(
                      icon: _isVideoOn ? Icons.videocam : Icons.videocam_off,
                      isActive: _isVideoOn,
                      onTap: () => setState(() => _isVideoOn = !_isVideoOn),
                    ),
                    _buildControlButton(
                      icon: _isMuted ? Icons.mic_off : Icons.mic,
                      isActive: !_isMuted,
                      onTap: () => setState(() => _isMuted = !_isMuted),
                    ),
                    _buildControlButton(
                      icon: _isSpeakerOn ? Icons.volume_up : Icons.phone_in_talk,
                      isActive: _isSpeakerOn,
                      onTap: () => setState(() => _isSpeakerOn = !_isSpeakerOn),
                    ),
                    // زر إنهاء المكالمة
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                        child: const Icon(Icons.call_end, color: Colors.white, size: 30),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAdvancedAudioControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // زر تقليل التشويش المعتمد على الذكاء الاصطناعي
        _buildAdvancedToggle(
          title: "AI Denoise",
          icon: Icons.noise_control_off,
          isActive: _noiseCancellationEnabled,
          onTap: () => setState(() => _noiseCancellationEnabled = !_noiseCancellationEnabled),
        ),
        
        // تبديل مسار الصوت (ستيريو)
        GestureDetector(
          onTap: () {
            setState(() {
              if (_audioRouting == "Mono") _audioRouting = "Stereo";
              else if (_audioRouting == "Stereo") _audioRouting = "Surround";
              else _audioRouting = "Mono";
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                const Icon(Icons.speaker, color: Colors.white70, size: 16),
                const SizedBox(width: 6),
                Text(_audioRouting, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),

        // زر الصوت المحيطي (Dolby Atmos)
        _buildAdvancedToggle(
          title: "Spatial",
          icon: Icons.surround_sound,
          isActive: _spatialAudioEnabled,
          onTap: () => setState(() => _spatialAudioEnabled = !_spatialAudioEnabled),
          activeColor: Colors.deepPurpleAccent,
        ),
      ],
    );
  }

  Widget _buildAdvancedToggle({required String title, required IconData icon, required bool isActive, required VoidCallback onTap, Color activeColor = Colors.blueAccent}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: isActive ? activeColor : Colors.grey, size: 28),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: isActive ? activeColor : Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildControlButton({required IconData icon, required bool isActive, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isActive ? Colors.white.withOpacity(0.15) : Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: isActive ? Colors.white : Colors.black, size: 28),
      ),
    );
  }
}
