// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neurofit_app/core/constants/constants.dart';

// State provider to toggle front/back view
final isFrontProvider = StateProvider<bool>((ref) => true);

// Selected muscle
final selectedMuscleProvider = StateProvider<String?>((ref) => null);


class InteractiveBody extends ConsumerWidget {
  const InteractiveBody({
    super.key,
    required this.isFront,
  });

  final bool isFront;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 650,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              //Front muscles
              if (isFront)
                Positioned(
                  left: constraints.maxWidth * 0.32,
                  top: constraints.maxHeight * -0.09,
                  width: constraints.maxWidth * 0.35,
                  height: constraints.maxHeight * 0.40,
                  child: Transform.rotate(
                    angle: 90 * 3.1416 / 180,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => ref
                          .read(selectedMuscleProvider.notifier)
                          .state = 'Shoulders',
                      child: SvgPicture.asset(
                        'assets/muscles/front/Shoulders.svg',
                        color: ref.watch(selectedMuscleProvider) == 'Shoulders'
                            ? kBlue
                            : Colors.blue,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              if (isFront)
                Positioned(
                  left: constraints.maxWidth * 0.325,
                  top: constraints.maxHeight * 0.074,
                  width: constraints.maxWidth * 0.34,
                  height: constraints.maxHeight * 0.39,
                  child: Transform.rotate(
                    angle: 90 * 3.1416 / 180,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => ref
                          .read(selectedMuscleProvider.notifier)
                          .state = 'Bicep',
                      child: SvgPicture.asset(
                        'assets/muscles/front/Bicep.svg',
                        color: ref.watch(selectedMuscleProvider) == 'Bicep'
                            ? kBlue
                            : Colors.blue,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

              if (isFront)
                Positioned(
                  left: constraints.maxWidth * 0.29,
                  top: constraints.maxHeight * 0.175,
                  width: constraints.maxWidth * 0.41,
                  height: constraints.maxHeight * 0.46,
                  child: Transform.rotate(
                    angle: 90 * 3.1416 / 180,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => ref
                          .read(selectedMuscleProvider.notifier)
                          .state = 'ForeArms',
                      child: SvgPicture.asset(
                        'assets/muscles/front/Forearms.svg',
                        color: ref.watch(selectedMuscleProvider) == 'ForeArms'
                            ? kBlue
                            : Colors.blue,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              if (isFront)
                Positioned(
                  left: constraints.maxWidth * 0.255,
                  top: constraints.maxHeight * 0.15,
                  width: constraints.maxWidth * 0.48,
                  height: constraints.maxHeight * 0.33,
                  child: Transform.rotate(
                    angle: 90 * 3.1416 / 180,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => ref
                          .read(selectedMuscleProvider.notifier)
                          .state = 'Obliques',
                      child: SvgPicture.asset(
                        'assets/muscles/front/Side abs.svg',
                        color: ref.watch(selectedMuscleProvider) == 'Obliques'
                            ? kBlue
                            : Colors.blue,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              if (isFront)
                Positioned(
                  left: constraints.maxWidth * 0.345,
                  top: constraints.maxHeight * 0.045,
                  width: constraints.maxWidth * 0.30,
                  height: constraints.maxHeight * 0.24,
                  child: Transform.rotate(
                    angle: 90 * 3.1416 / 180,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => ref
                          .read(selectedMuscleProvider.notifier)
                          .state = 'Chest',
                      child: SvgPicture.asset(
                        'assets/muscles/front/Chest.svg',
                        color: ref.watch(selectedMuscleProvider) == 'Chest'
                            ? kBlue
                            : Colors.blue,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

              if (isFront)
                Positioned(
                  left: constraints.maxWidth * 0.267,
                  top: constraints.maxHeight * 0.09,
                  width: constraints.maxWidth * 0.45,
                  height: constraints.maxHeight * 0.55,
                  child: Transform.rotate(
                    angle: 90 * 3.1416 / 180,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => ref
                          .read(selectedMuscleProvider.notifier)
                          .state = 'Abs',
                      child: SvgPicture.asset(
                        'assets/muscles/front/Abs.svg',
                        color: ref.watch(selectedMuscleProvider) == 'Abs'
                            ? kBlue
                            : Colors.blue,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

              if (isFront)
                Positioned(
                  left: constraints.maxWidth * 0.22,
                  top: constraints.maxHeight * 0.375,
                  width: constraints.maxWidth * 0.55,
                  height: constraints.maxHeight * 0.45,
                  child: Transform.rotate(
                    angle: 90 * 3.1416 / 180,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => ref
                          .read(selectedMuscleProvider.notifier)
                          .state = 'Quads',
                      child: SvgPicture.asset(
                        'assets/muscles/front/Legs.svg',
                        color: ref.watch(selectedMuscleProvider) == 'Quads'
                            ? kBlue
                            : Colors.blue,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              if (isFront)
                Positioned(
                  left: constraints.maxWidth * 0.30,
                  top: constraints.maxHeight * 0.77,
                  width: constraints.maxWidth * 0.38,
                  height: constraints.maxHeight * 0.28,
                  child: Transform.rotate(
                    angle: 90 * 3.1416 / 180,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => ref
                          .read(selectedMuscleProvider.notifier)
                          .state = 'Shin',
                      child: SvgPicture.asset(
                        'assets/muscles/front/Front calf.svg',
                        color: ref.watch(selectedMuscleProvider) == 'Shin'
                            ? kBlue
                            : Colors.blue,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              //Back muscles
              if (!isFront)
                Positioned(
                  left: constraints.maxWidth * 0.34,
                  top: constraints.maxHeight * -0.04,
                  width: constraints.maxWidth * 0.30,
                  height: constraints.maxHeight * 0.35,
                  child: Transform.rotate(
                    angle: 90 * 3.1416 / 180,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => ref
                          .read(selectedMuscleProvider.notifier)
                          .state = 'Delts',
                      child: SvgPicture.asset(
                        'assets/muscles/back/Delta.svg',
                        color: ref.watch(selectedMuscleProvider) == 'Delts'
                            ? kBlue
                            : Colors.blue,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              if (!isFront)
                Positioned(
                  left: constraints.maxWidth * 0.34,
                  top: constraints.maxHeight * 0.05,
                  width: constraints.maxWidth * 0.305,
                  height: constraints.maxHeight * 0.355,
                  child: Transform.rotate(
                    angle: 90 * 3.1416 / 180,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => ref
                          .read(selectedMuscleProvider.notifier)
                          .state = 'Triceps',
                      child: SvgPicture.asset(
                        'assets/muscles/back/Tricep.svg',
                        color: ref.watch(selectedMuscleProvider) == 'Triceps'
                            ? kBlue
                            : Colors.blue,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              if (!isFront)
                Positioned(
                  left: constraints.maxWidth * 0.305,
                  top: constraints.maxHeight * 0.16,
                  width: constraints.maxWidth * 0.37,
                  height: constraints.maxHeight * 0.42,
                  child: Transform.rotate(
                    angle: 90 * 3.1416 / 180,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => ref
                          .read(selectedMuscleProvider.notifier)
                          .state = 'ForeArms',
                      child: SvgPicture.asset(
                        'assets/muscles/back/Back forearm.svg',
                        color: ref.watch(selectedMuscleProvider) == 'ForeArms'
                            ? kBlue
                            : Colors.blue,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

              if (!isFront)
                Positioned(
                  left: constraints.maxWidth * 0.195,
                  top: constraints.maxHeight * -0.09,
                  width: constraints.maxWidth * 0.60,
                  height: constraints.maxHeight * 0.55,
                  child: Transform.rotate(
                    angle: 90 * 3.1416 / 180,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => ref
                          .read(selectedMuscleProvider.notifier)
                          .state = 'Back',
                      child: SvgPicture.asset(
                        'assets/muscles/back/Back.svg',
                        color: ref.watch(selectedMuscleProvider) == 'Back'
                            ? kBlue
                            : Colors.blue,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              if (!isFront)
                Positioned(
                  left: constraints.maxWidth * 0.375,
                  top: constraints.maxHeight * 0.175,
                  width: constraints.maxWidth * 0.24,
                  height: constraints.maxHeight * 0.34,
                  child: Transform.rotate(
                    angle: 90 * 3.1416 / 180,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => ref
                          .read(selectedMuscleProvider.notifier)
                          .state = 'Lower Back',
                      child: SvgPicture.asset(
                        'assets/muscles/back/Lower back.svg',
                        color: ref.watch(selectedMuscleProvider) == 'Lower Back'
                            ? kBlue
                            : Colors.blue,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

              if (!isFront)
                Positioned(
                  left: constraints.maxWidth * 0.27,
                  top: constraints.maxHeight * 0.36,
                  width: constraints.maxWidth * 0.45,
                  height: constraints.maxHeight * 0.55,
                  child: Transform.rotate(
                    angle: 90 * 3.1416 / 180,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => ref
                          .read(selectedMuscleProvider.notifier)
                          .state = 'Hamstrings',
                      child: SvgPicture.asset(
                        'assets/muscles/back/Hamstring.svg',
                        color: ref.watch(selectedMuscleProvider) == 'Hamstrings'
                            ? kBlue
                            : Colors.blue,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              if (!isFront)
                Positioned(
                  left: constraints.maxWidth * 0.377,
                  top: constraints.maxHeight * 0.295,
                  width: constraints.maxWidth * 0.24,
                  height: constraints.maxHeight * 0.34,
                  child: Transform.rotate(
                    angle: 90 * 3.1416 / 180,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => ref
                          .read(selectedMuscleProvider.notifier)
                          .state = 'Glutes',
                      child: SvgPicture.asset(
                        'assets/muscles/back/Ass.svg',
                        color: ref.watch(selectedMuscleProvider) == 'Glutes'
                            ? kBlue
                            : Colors.blue,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

              if (!isFront)
                Positioned(
                  left: constraints.maxWidth * 0.3,
                  top: constraints.maxHeight * 0.61,
                  width: constraints.maxWidth * 0.39,
                  height: constraints.maxHeight * 0.49,
                  child: Transform.rotate(
                    angle: 90 * 3.1416 / 180,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => ref
                          .read(selectedMuscleProvider.notifier)
                          .state = 'Calfs',
                      child: SvgPicture.asset(
                        'assets/muscles/back/Calfs.svg',
                        color: ref.watch(selectedMuscleProvider) == 'Calfs'
                            ? kBlue
                            : Colors.blue,
                        fit: BoxFit.contain,
                      ),
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
