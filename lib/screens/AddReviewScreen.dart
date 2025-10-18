import 'package:flutter/material.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  // State variable to hold the slider's current value
  double _starRating = 2.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back navigation
            // Navigator.of(context).pop();
          },
        ),
        title: const Text('Add Review'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ## Name Input Section
            const Text(
              'Name',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(hintText: 'Type your name'),
            ),
            const SizedBox(height: 24),

            // ## Experience Input Section
            const Text(
              'How was your experience ?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const TextField(
              maxLines: 5, // Allows for multi-line input
              decoration: InputDecoration(
                hintText: 'Describe your experience?',
              ),
            ),
            const SizedBox(height: 24),

            // ## Star Rating Section
            const Text(
              'Star',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('0.0', style: TextStyle(color: Colors.grey)),
                Expanded(
                  child: Slider(
                    value: _starRating,
                    min: 0.0,
                    max: 5.0,
                    divisions: 10, // Allows for half-star ratings
                    label: _starRating.toStringAsFixed(1),
                    activeColor: Colors.deepPurpleAccent,
                    inactiveColor: Colors.grey[200],
                    onChanged: (double value) {
                      setState(() {
                        _starRating = value;
                      });
                    },
                  ),
                ),
                const Text('5.0', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
      // ## Submit Button
      // Using bottomNavigationBar for a clean layout that avoids keyboard overlap
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ElevatedButton(
          onPressed: () {
            // Handle submit review action
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('Submit Review'),
        ),
      ),
    );
  }
}
