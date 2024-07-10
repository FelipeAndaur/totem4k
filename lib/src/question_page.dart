import 'package:flutter/material.dart';
import 'result_page.dart';

class QuestionPage extends StatefulWidget {
  final int questionIndex;
  final List<bool> answers;

  QuestionPage(this.questionIndex, {this.answers = const []});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List<Map<String, String>> questions = [
    {
      "image":
          "assets/images/Q1-Frutas.png" // Primera pregunta con la imagen incluida
    },
    // Agrega más preguntas e imágenes aquí
  ];

  void _answerQuestion(bool answer) {
    List<bool> answers = List.from(widget.answers);
    answers.add(answer);

    if (widget.questionIndex + 1 < questions.length) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              QuestionPage(widget.questionIndex + 1, answers: answers),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(answers),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String imagePath = questions[widget.questionIndex]["image"]!;

    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          // Botones de respuesta
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _answerQuestion(true),
                  child: const Text('Sí'),
                ),
                ElevatedButton(
                  onPressed: () => _answerQuestion(false),
                  child: const Text('No'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
