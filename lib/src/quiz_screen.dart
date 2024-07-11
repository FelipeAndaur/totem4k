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
                  fit: BoxFit.fitWidth,
                ),
              ),
              // Botones
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 60,
                        child: CustomButton(
                          text: 'Sí',
                          onPressed: () {
                            // Manejar la respuesta "Sí"
                          },
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        height: 60,
                        child: CustomButton(
                          text: 'No',
                          onPressed: () {
                            // Manejar la respuesta "No"
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({required this.text, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, backgroundColor: Colors.grey[300], padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ), // Color del texto del botón
        textStyle: const TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
      ),
      child: Text(text),
    );
  }
}
