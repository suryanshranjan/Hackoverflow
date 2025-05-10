import 'dart:async';
import 'package:flutter/material.dart';

class TilesSection extends StatefulWidget {
  const TilesSection({super.key});

  @override
  State<TilesSection> createState() => _TilesSectionState();
}

class _TilesSectionState extends State<TilesSection> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<_TileData> _tiles = [
    _TileData(
      text: '🧪 New Vaccine Update: Trials for RSV show 95% effectiveness.',
      colors: [Color(0xFFC8E6C9), Color(0xFF4CAF50)], // yellow-orange
    ),
    _TileData(
      text: '📚 CME Lecture: AI in Radiology on May 15 at 3PM.',
      colors: [Color(0xFFB3E5FC), Color(0xFF03A9F4)], // blue
    ),
    _TileData(
      text:
          '📢 Announcement: New patient portal launched with telemedicine features.',
      colors: [Color(0xFFFFE082), Color(0xFFFFC107)], // green
    ),
    _TileData(
      text:
          '🧬 Research: Breakthrough in gene therapy for rare blood disorders.',
      colors: [Color(0xFFD1C4E9), Color(0xFF673AB7)], // purple
    ),
    _TileData(
      text: '💊 Drug Alert: FDA recalls batch of Metformin XR 500mg.',
      colors: [Color(0xFFFFCDD2), Color(0xFFE53935)], // red
    ),
  ];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_pageController.hasClients) {
        int nextPage = (_currentIndex + 1) % _tiles.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
        setState(() => _currentIndex = nextPage);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.only(top: 12),
      child: PageView.builder(
        controller: _pageController,
        itemCount: _tiles.length,
        itemBuilder: (context, index) {
          return _buildTile(_tiles[index]);
        },
      ),
    );
  }

  Widget _buildTile(_TileData tile) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: tile.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.local_hospital, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tile.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _TileData {
  final String text;
  final List<Color> colors;

  _TileData({required this.text, required this.colors});
}
