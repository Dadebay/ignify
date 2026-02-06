import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makc/core/constants/icon_constants.dart';
import 'package:makc/core/constants/image_constants.dart';

class FeaturedPlace {
  final String name;
  final String category;
  final String location;
  final String imagePath;
  final String logoPath;

  FeaturedPlace({
    required this.name,
    required this.category,
    required this.location,
    required this.imagePath,
    required this.logoPath,
  });
}

class ActivityPlace {
  final String name;
  final String category;
  final String status;
  final Color statusColor;
  final double rating;
  final double distance;
  final String logoPath;

  ActivityPlace({
    required this.name,
    required this.category,
    required this.status,
    required this.statusColor,
    required this.rating,
    required this.distance,
    required this.logoPath,
  });
}

class CommunityPost {
  final String userName;
  final String userRole;
  final String userImage;
  final String timeAgo;
  final String content;
  final String? postImage;
  final String? pdfName;
  final String? pdfSize;
  final int comments;
  final int likes;

  CommunityPost({
    required this.userName,
    required this.userRole,
    required this.userImage,
    required this.timeAgo,
    required this.content,
    this.postImage,
    this.pdfName,
    this.pdfSize,
    required this.comments,
    required this.likes,
  });
}

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String _selectedTab = 'Activity places'; // 'Activity places' or 'Your community'
  String _selectedFilter = 'All';

  final List<FeaturedPlace> _featuredPlaces = [
    FeaturedPlace(
      name: 'Music Academy of Kansas City',
      category: 'Education',
      location: 'Overland Park, Kansas',
      imagePath: ImageConstants.featured1,
      logoPath: ImageConstants.logo1,
    ),
    FeaturedPlace(
      name: 'Little Stars Dance Academy',
      category: 'Dance Academy',
      location: 'Kansas',
      imagePath: ImageConstants.featured2,
      logoPath: ImageConstants.logo3, // Fixed as per previous user edits
    ),
  ];

  final List<ActivityPlace> _allActivities = [
    ActivityPlace(
      name: 'Harmony House Music Lessons',
      category: 'Music Academy',
      status: 'Open',
      statusColor: const Color(0xFF4CAF50),
      rating: 4.8,
      distance: 1.24,
      logoPath: ImageConstants.logo5,
    ),
    ActivityPlace(
      name: 'The Creative . Canvas Art School',
      category: 'Art school',
      status: 'Closes soon',
      statusColor: const Color(0xFFFFC107),
      rating: 4.5,
      distance: 2.1,
      logoPath: ImageConstants.logo4,
    ),
    ActivityPlace(
      name: 'Little Stars Dance Academy',
      category: 'Dance Academy',
      status: 'Closed',
      statusColor: const Color(0xFFE91E63),
      rating: 4.9,
      distance: 1.24,
      logoPath: ImageConstants.logo3,
    ),
  ];

  final List<CommunityPost> _communityPosts = [
    CommunityPost(
      userName: 'Tatyana',
      userRole: 'Yoga studio',
      userImage: ImageConstants.commUser1,
      timeAgo: '17:00 PM', // Design shows exact time sometimes
      content: 'Today our students mastered new poses—so proud of their journey!',
      postImage: ImageConstants.commFrame,
      comments: 4,
      likes: 10,
    ),
    CommunityPost(
      userName: 'Jessie',
      userRole: 'Music Academy',
      userImage: ImageConstants.commUser2,
      timeAgo: '1d ago',
      content: 'Children’s progress and upcoming music events in this week’s PDF!',
      pdfName: 'Progress.pdf',
      pdfSize: '4.2 MB',
      comments: 4,
      likes: 10,
    ),
    CommunityPost(
      userName: 'Tomas',
      userRole: 'Harmony Music Academy',
      userImage: ImageConstants.commUser3,
      timeAgo: '2d ago',
      content:
          'We are thrilled to share the wonderful progress your children have made in their music classes this week! Our young musicians have been exploring new rhythms, mastering challenging melodies, and expressing themselves more confidently through their instruments. Each practice session shows their dedication and creativity, and it is truly inspiring to watch them grow.\nTo support their journey at home, we encourage you to listen to their practice pieces together, provide gentle guidance, and celebrate their small victories. Your involvement makes a huge difference in fostering their love for music and building their confidence. Don’t forget, we have an upcoming mini recital scheduled for next week, where your child will...',
      comments: 4,
      likes: 10,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Explore',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Find activities near you',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _TabHeaderDelegate(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildTabButton('Activity places'),
                        ),
                        Expanded(
                          child: _buildTabButton('Your community'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _selectedTab == 'Activity places' ? _buildActivityPlacesView() : _buildCommunityView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String title) {
    final isSelected = _selectedTab == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.black : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityPlacesView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // AI Suggestion Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFBF3FA),
            border: Border.all(color: const Color(0xFFE9D6FF)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0, top: 2),
                    child: SvgPicture.asset(
                      IconConstants.aiIcon,
                      color: const Color(0xFF972AF7),
                      width: 20,
                      height: 20,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Based on your learning patterns, we suggest "Advanced Harmony & Chord Progressions" to complement your current studies.',
                      style: TextStyle(
                        color: const Color(0xFF972AF7),
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF972AF7),
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'View course',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Featured Section
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Featured',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _featuredPlaces.length,
            itemBuilder: (context, index) {
              final place = _featuredPlaces[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: _buildFeaturedCard(place),
              );
            },
          ),
        ),
        const SizedBox(height: 24),

        // Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildFilterChip('All'),
              const SizedBox(width: 8),
              _buildFilterChip('Studios'),
              const SizedBox(width: 8),
              _buildFilterChip('Schools'),
              const SizedBox(width: 8),
              _buildFilterChip('Activities'),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Activity List
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: _allActivities.map((activity) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildActivityCard(activity),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCommunityView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Blue Info Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD), // Light blue
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF90CAF9)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.auto_awesome, color: Color(0xFF1976D2), size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Users who engage with the community practice 40% more consistently. Join discussions to boost your learning!',
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Connect With Your Community',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: _communityPosts.map((post) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: _buildCommunityPost(post),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCommunityPost(CommunityPost post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(post.userImage),
              radius: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    post.userRole,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              post.timeAgo,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Text Content
        Text(
          post.content,
          style: const TextStyle(fontSize: 14, height: 1.4),
        ),
        const SizedBox(height: 12),

        // Media Content (Image or PDF)
        if (post.postImage != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              post.postImage!,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        if (post.pdfName != null)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Image.asset(ImageConstants.commPdf, width: 40, height: 40),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.pdfName!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      post.pdfSize!,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

        const SizedBox(height: 12),

        // Action Buttons
        Row(
          children: [
            Icon(Icons.chat_bubble_outline, size: 18, color: Colors.grey[400]),
            const SizedBox(width: 6),
            Text(
              '${post.comments} comment',
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
            const SizedBox(width: 16),
            Icon(Icons.favorite_border, size: 18, color: Colors.grey[400]),
            const SizedBox(width: 6),
            Text(
              '${post.likes} likes',
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
            const Spacer(),
            CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFFFAFAFA),
              child: Icon(Icons.favorite_border, size: 20, color: Colors.grey[600]),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFFFAFAFA),
              child: Icon(Icons.chat_bubble_outline, size: 20, color: Colors.grey[600]),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFFFAFAFA),
              child: Icon(Icons.share, size: 20, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturedCard(FeaturedPlace place) {
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              place.imagePath,
              width: 280,
              height: 160,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 280,
                  height: 160,
                  color: Colors.grey[300],
                  child: Icon(Icons.image, color: Colors.grey[500], size: 48),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  place.logoPath,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.image, color: Colors.grey[500], size: 20),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${place.category} · ${place.location}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E88E5) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.grey[700],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard(ActivityPlace activity) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              activity.logoPath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.image, color: Colors.grey[500], size: 30),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    activity.category,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.schedule, color: activity.statusColor, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        activity.status,
                        style: TextStyle(
                          fontSize: 13,
                          color: activity.statusColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (activity.rating > 0) ...[
                        const SizedBox(width: 12),
                        const Icon(Icons.star, color: Color(0xFFFFC107), size: 16),
                        const SizedBox(width: 4),
                        Text(
                          activity.rating.toString(),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                      const SizedBox(width: 12),
                      Icon(Icons.location_on, color: Colors.blue[600], size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${activity.distance} mi',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _TabHeaderDelegate({required this.child});

  @override
  double get minExtent => 72;

  @override
  double get maxExtent => 72;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _TabHeaderDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}
