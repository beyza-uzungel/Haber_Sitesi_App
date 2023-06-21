import 'package:flutter/material.dart';

class AnimatedPhoto extends StatefulWidget {
  const AnimatedPhoto({Key? key}) : super(key: key);

  @override
  _AnimatedPhotoState createState() => _AnimatedPhotoState();
}

class _AnimatedPhotoState extends State<AnimatedPhoto> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 12), // Animasyon süresini belirleyin
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -0.3), // Başlangıç konumu (yukarıda)
      end: const Offset(0.0, 0.0), // Bitiş konumu (aşağıda)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut, // Animasyon eğrisi
    ));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward(); // Animasyonu başlatmak için

    return SlideTransition(
        position: _offsetAnimation, child: Container(width: 150,
        height: 150,
          child: Image.asset('assets/wrd.png')));
  }
}