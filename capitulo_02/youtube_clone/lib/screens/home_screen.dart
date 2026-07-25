import 'package:flutter/material.dart';
import '../widgets/video_card.dart';
import '../widgets/category_bar.dart';
import '../widgets/shorts_section.dart';
import '../models/video.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/b/b8/YouTube_Logo_2017.svg',
          height: 20,
          color: Colors.white, // Simplification for demo
          errorBuilder: (context, error, stackTrace) => const Text(
            'YouTube',
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: -1),
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.cast), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.blue,
              child: Text('E', style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: CategoryBar()),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // Alternating between videos and shorts to demonstrate multiple lists
                if (index == 1) {
                  return const ShortsSection();
                }
                
                // Adjust index for video data access
                int videoIndex = index > 1 ? index - 1 : index;
                if (videoIndex >= demoVideos.length) {
                  // Repeat demo videos for infinite scroll feel
                  videoIndex = videoIndex % demoVideos.length;
                }
                
                return VideoCard(video: demoVideos[videoIndex]);
              },
              childCount: 10, // Sufficient for demonstration
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle_outline), activeIcon: Icon(Icons.play_circle), label: 'Shorts'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline, size: 40), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.subscriptions_outlined), activeIcon: Icon(Icons.subscriptions), label: 'Subscriptions'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'You'),
        ],
        selectedFontSize: 10,
        unselectedFontSize: 10,
      ),
    );
  }
}
