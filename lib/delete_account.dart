import 'package:flutter/material.dart';
import 'package:ui_test/components/gap.dart';

import 'components/animated_border_painter.dart';
import 'components/cancel_button_widget.dart';
import 'components/progress_button.dart';
import 'util/constants.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double gradientProgress = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CustomPaint(
              painter: AnimatedBorderPainter(animation: _controller),
              child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: gradientProgress),
                  duration: const Duration(seconds: 1),
                  builder: (_, progress, child) {
                    return Container(
                      width: 250,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF1E1E1E),
                              Color.lerp(const Color(0xFF1E1E1E),
                                  kPrimaryColor.withOpacity(0.2), progress)!,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.circular(kBorderRadius)),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimaryColor,
                            ),
                            child: const Icon(
                              Icons.priority_high_outlined,
                              color: Colors.white,
                            ),
                          ),
                          gapY(10),
                          const Text(
                            "Delete Account",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          gapY(10),
                          const Text(
                            "Are you sure you want to delete your account?",
                            style: TextStyle(
                                color: Color(0xFF636363), fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                          gapY(10),
                          GestureDetector(
                            onTapDown: (_) {
                              _controller.forward();

                              setState(() {
                                gradientProgress = 1.0;
                              });
                            },
                            onTapUp: (_) {
                              _controller.reverse();

                              setState(() {
                                gradientProgress = 0.0;
                              });
                            },
                            onTapCancel: () {
                              _controller.reverse();

                              setState(() {
                                gradientProgress = 0.0;
                              });
                            },
                            child: ProgressButton(
                              size: const Size(250, kButtonHeight),
                              progress: progress,
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
        ),
        gapY(10),
        const CancelButtonWidget()
      ],
    );
  }
}
