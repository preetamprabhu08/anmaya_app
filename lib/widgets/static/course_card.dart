import 'package:flutter/material.dart';
import 'package:anmaya/app_colors.dart';


class CourseCard extends StatelessWidget {
  final String title;
  final String thumbnailUrl;
  final int totalSubscribers;
  final String instructorName;
  final double price;
  final double rating;
  const CourseCard({
    super.key,
    required this.title,
    required this.thumbnailUrl,
    required this.totalSubscribers,
    required this.instructorName,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.black2,
      elevation: 8,
      shadowColor: Colors.blue.withOpacity(0.15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double imageHeight = constraints.maxHeight * 0.48;
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                        child: Image.network(
                          thumbnailUrl,
                          height: imageHeight,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: imageHeight,
                            color: Colors.grey[900],
                            child: const Center(child: Icon(Icons.broken_image, color: Colors.white38, size: 48)),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 16,
                        child: _RatingBadge(rating: rating),
                      ),
                      Positioned(
                        right: 16,
                        top: 16,
                        child: _PriceBadge(price: price),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.blueGrey[800],
                              child: Text(
                                instructorName.isNotEmpty ? instructorName[0].toUpperCase() : '?',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                instructorName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _Pill(label: 'Beginner', color: Colors.blue),
                            const SizedBox(width: 8),
                            _Pill(label: 'Certificate', color: Colors.green),
                            const SizedBox(width: 8),
                            _Pill(label: 'Updated', color: Colors.orange),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.group, size: 18, color: Colors.white70),
                            const SizedBox(width: 6),
                            Text('$totalSubscribers Subscribers', style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 12,
                child: Center(
                  child: _AnimatedExploreButton(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final Color color;
  const _Pill({required this.label, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }
}

class _PriceBadge extends StatelessWidget {
  final double price;
  const _PriceBadge({required this.price});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.85),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Text(
        '₹${price.toStringAsFixed(0)}',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  final double rating;
  const _RatingBadge({required this.rating});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.yellow[800]?.withOpacity(0.95),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.yellow[900]?.withOpacity(0.18) ?? Colors.transparent,
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.white, size: 17),
          const SizedBox(width: 5),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class _AnimatedExploreButton extends StatefulWidget {
  @override
  State<_AnimatedExploreButton> createState() => _AnimatedExploreButtonState();
}

class _AnimatedExploreButtonState extends State<_AnimatedExploreButton> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: _hovering
                ? [Colors.blue, Colors.black]
                : [Colors.blue.withOpacity(0.6), Colors.black.withOpacity(0.4)],
            stops: const [0.6, 1.0],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          ),
          onPressed: () {},
          child: const Text('Explore Now'),
        ),
      ),
    );
  }
}