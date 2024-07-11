import 'package:flutter/material.dart';
import 'controllers/quiz_controller.dart';

class ResultScreen extends StatelessWidget {
  final QuizController controller;

  const ResultScreen({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Respuestas "Sí": ${controller.yesCount}', style: TextStyle(fontSize: 24)),
            Text('Respuestas "No": ${controller.noCount}', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
