import 'package:flutter/material.dart';
import 'package:totem4k/main.dart';

class ResultPage extends StatelessWidget {
  final List<bool> answers;

  ResultPage(this.answers);

  @override
  Widget build(BuildContext context) {
    int score = answers.where((answer) => answer).length;
    double percentage = (score / answers.length) * 100;

    String resultText;
    if (percentage >= 60) {
      resultText = 'Aprobado';
    } else {
      resultText = 'Reprobado';
    }

    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/images/home.png', // Usa una imagen adecuada para la página de resultados
              fit: BoxFit.cover,
            ),
          ),
          // Contenido de la aplicación
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Tu puntuación: $score/${answers.length}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Porcentaje: ${percentage.toStringAsFixed(2)}%',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Resultado: $resultText',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) =>  MyApp()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text('Volver a Empezar'),
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
