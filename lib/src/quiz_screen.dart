import 'package:flutter/material.dart';
import 'package:totem4k/main.dart';
import 'controllers/quiz_controller.dart';
import 'result_screens.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  late QuizController _controller;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _controller = QuizController(9); // Número de preguntas
  }

  void _onAnswerSelected(int index, int answer) {
    setState(() {
      _controller.setAnswer(index, answer);
    });

    if (index < _controller.numberOfQuestions - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(controller: _controller),
        ),
      );
    }
  }

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
        controller: _pageController,
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
              // Icono de home
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: const Icon(Icons.home, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) =>  const HomeScreen()),
                      (route) => false,
                    );
                  },
                ),
              ),
              // Botones
              Positioned(
                bottom: 180,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 150,
                        child: CustomButton(
                          text: 'SI',
                          isSelected: _controller.getAnswer(index) == 0,
                          selectedTextColor: Colors.green,
                          onPressed: () {
                            _onAnswerSelected(index, 0);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        height: 150,
                        child: CustomButton(
                          text: 'NO',
                          isSelected: _controller.getAnswer(index) == 1,
                          selectedTextColor: Colors.red,
                          onPressed: () {
                            _onAnswerSelected(index, 1);
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
  final bool isSelected;
  final Color selectedTextColor;
  final VoidCallback onPressed;

  const CustomButton({
    required this.text,
    required this.isSelected,
    required this.selectedTextColor,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: isSelected ? selectedTextColor : Colors.black,
        backgroundColor: Colors.grey[300],
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Goldplay',
            fontSize: 300,
            fontWeight: FontWeight.w900,
            color: isSelected ? selectedTextColor : Colors.black,
          ),
        ),
      ),
    );
  }
}
