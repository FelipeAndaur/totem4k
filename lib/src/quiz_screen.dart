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

  final List<String> images = [
    'assets/images/Q1.webp',
    'assets/images/Q2.webp',
    'assets/images/Q3.webp',
    'assets/images/Q4.webp',
    'assets/images/Q5.webp',
    'assets/images/Q6.webp',
    'assets/images/Q7.webp',
    'assets/images/Q8.webp',
    'assets/images/Q9.webp',
  ];

  @override
  void initState() {
    super.initState();
    _controller = QuizController(9); // Número de preguntas
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precargar todas las imágenes
    for (var imagePath in images) {
      precacheImage(AssetImage(imagePath), context);
    }
  }

  void _onAnswerSelected(int index, int answer) {
    setState(() {
      _controller.setAnswer(index, answer);
    });

    if (index < _controller.numberOfQuestions - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ResultScreen(controller: _controller),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration:
              const Duration(milliseconds: 800), // Duración de la transición
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  fit: BoxFit.cover,
                ),
              ),
              // Icono de home
              // Icono de home
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: const Icon(Icons.home, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const HomeScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, -1.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(
                            milliseconds: 800), // Duración de la transición
                      ),
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
