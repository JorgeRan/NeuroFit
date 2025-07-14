import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestSvgRotation extends StatelessWidget {
  const TestSvgRotation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test SVG Rotation')),
      body: LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              left: constraints.maxWidth * 0.42,
              top: constraints.maxHeight * 0.2,
              width: constraints.maxWidth * 0.15,
              height: constraints.maxHeight * 0.12,
              child: Transform.rotate(
                angle: -90 * 3.1416 / 180,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/muscles/front/Chest.svg',
                  color: Colors.blue,
                  fit: BoxFit.contain,
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
