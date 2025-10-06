import 'package:flutter/material.dart';

// Placeholder image URLs for avatars
const String _jennyWilsonAvatar = 'https://example.com/avatar_jenny_wilson.jpg';
const String _ronaldRichardsAvatar = 'https://example.com/avatar_ronald_richards.jpg';
const String _guyHawkinsAvatar = 'https://example.com/avatar_guy_hawkins.jpg';
const String _savannahNguyenAvatar = 'https://example.com/avatar_savannah_nguyen.jpg';

class Review {
  final String reviewerName;
  final String reviewDate;
  final double rating;
  final String reviewText;
  final String avatarUrl;

  Review({
    required this.reviewerName,
    required this.reviewDate,
    required this.rating,
    required this.reviewText,
    required this.avatarUrl,
  });
}

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  // Sample data for reviews
  static final List<Review> _sampleReviews = [
    Review(
      reviewerName: "Jenny Wilson",
      reviewDate: "13 Sep, 2020",
      rating: 4.8,
      reviewText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...",
      avatarUrl: _jennyWilsonAvatar,
    ),
    Review(
      reviewerName: "Ronald Richards",
      reviewDate: "13 Sep, 2020",
      rating: 4.8,
      reviewText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...",
      avatarUrl: _ronaldRichardsAvatar,
    ),
    Review(
      reviewerName: "Guy Hawkins",
      reviewDate: "13 Sep, 2020",
      rating: 4.8,
      reviewText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...",
      avatarUrl: _guyHawkinsAvatar,
    ),
    Review(
      reviewerName: "Savannah Nguyen",
      reviewDate: "13 Sep, 2020",
      rating: 4.8,
      reviewText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae amet...",
      avatarUrl: _savannahNguyenAvatar,
    ),
    // Add more reviews as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back action
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Reviews",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "245 Reviews",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          "4.8",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        ...List.generate(5, (index) => Icon(
                          index < 4 // Assuming 4 full stars for 4.8, then a half
                              ? Icons.star
                              : (index == 4 ? Icons.star_half : Icons.star_border),
                          color: Colors.amber,
                          size: 18,
                        )),
                      ],
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle Add Review action
                  },
                  icon: const Icon(Icons.edit_outlined, color: Colors.white),
                  label: const Text(
                    "Add Review",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange, // Example orange color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _sampleReviews.length,
              separatorBuilder: (context, index) => const Divider(indent: 16, endIndent: 16),
              itemBuilder: (context, index) {
                final review = _sampleReviews[index];
                return ReviewCard(review: review);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(review.avatarUrl),
                radius: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          review.reviewerName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${review.rating.toStringAsFixed(1)} rating",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            Row(
                              children: List.generate(5, (index) => Icon(
                                index < review.rating.floor()
                                    ? Icons.star
                                    : (index == review.rating.floor() && review.rating % 1 != 0
                                    ? Icons.star_half // For half stars like 4.5
                                    : Icons.star_border),
                                color: Colors.amber,
                                size: 14,
                              )),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined, color: Colors.grey, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          review.reviewDate,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review.reviewText,
            style: const TextStyle(fontSize: 15),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}