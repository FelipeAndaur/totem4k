import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/images/Q1.png',
      'assets/images/Q2.png',
      'assets/images/Q3.png',
      'assets/images/Q4.png',
      'assets/images/Q5.png',
      'assets/images/Q6.png',
      'assets/images/Q7.png',
      'assets/images/Q8.png',
      'assets/images/Q9.png',
    ];

    return Scaffold(
      body: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              // Imagen de fondo
              Positioned.fill(
                child: Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
