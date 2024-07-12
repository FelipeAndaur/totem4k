import 'package:flutter/material.dart';
import 'package:totem4k/main.dart';
import 'controllers/quiz_controller.dart'; // Asegúrate de importar el controlador

class ResultScreen extends StatelessWidget {
  final QuizController controller;

  const ResultScreen({required this.controller, super.key});

  String _getResultImage() {
    double yesPercentage = (controller.yesCount / controller.numberOfQuestions) * 100;
    if (yesPercentage == 100) {
      return 'assets/images/R3.png';
    } else if (yesPercentage >= 30) {
      return 'assets/images/R2.png';
    } else {
      return 'assets/images/R1.png';
    }
  }

  String _getResultText() {
    double yesPercentage = (controller.yesCount / controller.numberOfQuestions) * 100;
    return '${yesPercentage.toStringAsFixed(0)}% DE\nEQUILIBRIO!';
  }

  @override
  Widget build(BuildContext context) {
    String resultImage = _getResultImage();
    String resultText = _getResultText();

    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              resultImage,
              fit: BoxFit.cover,
            ),
          ),
          // Contenido de resultados
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  resultText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Goldplay',
                    fontSize: 122,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1.0, // Ajusta esta propiedad para cambiar la separación entre líneas
                  ),
                ),
              ],
            ),
          ),
          // Botón de volver a empezar
         Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) =>  const HomeScreen()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.refresh, color: Color.fromARGB(255, 126, 126, 126)),
                    SizedBox(width: 10), // Espacio entre el icono y el texto
                    Text(
                      'VOLVER A EMPEZAR !',
                      style: TextStyle(
                        fontFamily: 'Goldplay',
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 126, 126, 126),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}