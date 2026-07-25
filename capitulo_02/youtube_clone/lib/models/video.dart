class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelName;
  final String channelProfileUrl;
  final String views;
  final String uploadedTime;
  final String duration;

  Video({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.channelName,
    required this.channelProfileUrl,
    required this.views,
    required this.uploadedTime,
    required this.duration,
  });
}

final List<Video> demoVideos = [
  Video(
    id: '1',
    title: 'Flutter UI Tutorial - YouTube Clone 2024 (60 FPS Performance)',
    thumbnailUrl: 'https://picsum.photos/seed/yt1/640/360',
    channelName: 'Flutter Mastery',
    channelProfileUrl: 'https://picsum.photos/seed/cp1/100/100',
    views: '1.2M views',
    uploadedTime: '2 hours ago',
    duration: '15:24',
  ),
  Video(
    id: '2',
    title: 'Clean Architecture with BLoC - Complete Guide',
    thumbnailUrl: 'https://picsum.photos/seed/yt2/640/360',
    channelName: 'Code With Me',
    channelProfileUrl: 'https://picsum.photos/seed/cp2/100/100',
    views: '850K views',
    uploadedTime: '1 day ago',
    duration: '42:10',
  ),
  Video(
    id: '3',
    title: 'Why Everyone is Switching to Kotlin Multiplatform (KMP)',
    thumbnailUrl: 'https://picsum.photos/seed/yt3/640/360',
    channelName: 'Tech Insider',
    channelProfileUrl: 'https://picsum.photos/seed/cp3/100/100',
    views: '2.5M views',
    uploadedTime: '3 days ago',
    duration: '10:05',
  ),
  Video(
    id: '4',
    title: 'Top 10 Flutter Packages You MUST Use in 2024',
    thumbnailUrl: 'https://picsum.photos/seed/yt4/640/360',
    channelName: 'App Dev Central',
    channelProfileUrl: 'https://picsum.photos/seed/cp4/100/100',
    views: '120K views',
    uploadedTime: '5 hours ago',
    duration: '08:45',
  ),
];
