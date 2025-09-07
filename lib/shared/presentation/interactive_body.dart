// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/data/providers/create_workout_providers.dart';


final isFrontProvider = StateProvider<bool>((ref) => true);

final selectedMuscleProvider = StateProvider<String?>((ref) => null);



Color getMuscleColor(WidgetRef ref, bool multiple, String muscle) {
  final isSelected = multiple
      ? ref.watch(selectedMuscleGroupsProvider).contains(muscle)
      : ref.watch(selectedMuscleProvider) == muscle;

  return isSelected ? (muscleGroupColors[muscle] ?? kBlue) : kNormalBlue;
}


void handleMuscleSelection({
  required WidgetRef ref,
  required bool multiple,
  required String muscle,
}) {
  if (multiple) {
    ref.read(selectedMuscleGroupsProvider.notifier).update((state) {
      final newState = [...state];
      if (newState.contains(muscle)) {
        newState.remove(muscle);
      } else {
        newState.add(muscle);
      }
      return newState;
    });
  } else {
    ref.read(selectedMuscleProvider.notifier).state = muscle;
  }
}

class InteractiveBody extends ConsumerWidget {
  const InteractiveBody(
    this.multiple, {
    super.key,
    required this.isFront,
  });

  final bool isFront;
  final bool multiple;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 650,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Front muscles
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
                      onTap: () => handleMuscleSelection(
                        ref: ref,
                        multiple: multiple,
                        muscle: 'Shoulders',
                      ),
                      child: SvgPicture.asset(
                        'assets/muscles/front/Shoulders.svg',
                        color: getMuscleColor(ref, multiple, "Shoulders"),
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
                      onTap: () => handleMuscleSelection(
                        ref: ref,
                        multiple: multiple,
                        muscle: 'Biceps',
                      ),
                      child: SvgPicture.asset(
                        'assets/muscles/front/Bicep.svg',
                        color: getMuscleColor(ref, multiple, "Biceps"),
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
                      onTap: () => handleMuscleSelection(
                        ref: ref,
                        multiple: multiple,
                        muscle: 'Forearms',
                      ),
                      child: SvgPicture.asset(
                        'assets/muscles/front/Forearms.svg',
                        color: getMuscleColor(ref, multiple, "Forearms"),
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
                      onTap: () => handleMuscleSelection(
                        ref: ref,
                        multiple: multiple,
                        muscle: 'Obliques',
                      ),
                      child: SvgPicture.asset(
                        'assets/muscles/front/Side abs.svg',
                        color: getMuscleColor(ref, multiple, "Obliques"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              if (isFront)
                Positioned(
                  left: constraints.maxWidth * 0.35,
                  top: constraints.maxHeight * 0.05,
                  width: constraints.maxWidth * 0.285,
                  height: constraints.maxHeight * 0.225,
                  child: Transform.rotate(
                    angle: 90 * 3.1416 / 180,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => handleMuscleSelection(
                        ref: ref,
                        multiple: multiple,
                        muscle: 'Chest',
                      ),
                      child: SvgPicture.asset(
                        'assets/muscles/front/Chest.svg',
                        color: getMuscleColor(ref, multiple, "Chest"),
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
                      onTap: () => handleMuscleSelection(
                        ref: ref,
                        multiple: multiple,
                        muscle: 'Abs',
                      ),
                      child: SvgPicture.asset(
                        'assets/muscles/front/Abs.svg',
                        color: getMuscleColor(ref, multiple, "Abs"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              if (isFront)
                Positioned(
                  left: constraints.maxWidth * 0.22,
                  top: constraints.maxHeight * 0.36,
                  width: constraints.maxWidth * 0.55,
                  height: constraints.maxHeight * 0.45,
                  child: Transform.rotate(
                    angle: 90 * 3.1416 / 180,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => handleMuscleSelection(
                        ref: ref,
                        multiple: multiple,
                        muscle: 'Quads',
                      ),
                      child: SvgPicture.asset(
                        'assets/muscles/front/Legs.svg',
                        color: getMuscleColor(ref, multiple, "Quads"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              if (isFront)
                Positioned(
                  left: constraints.maxWidth * 0.30,
                  top: constraints.maxHeight * 0.72,
                  width: constraints.maxWidth * 0.38,
                  height: constraints.maxHeight * 0.28,
                  child: Transform.rotate(
                    angle: 90 * 3.1416 / 180,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => handleMuscleSelection(
                        ref: ref,
                        multiple: multiple,
                        muscle: 'Calves',
                      ),
                      child: SvgPicture.asset(
                        'assets/muscles/front/Front calf.svg',
                        color: getMuscleColor(ref, multiple, "Calves"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              // Back muscles
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
                      onTap: () => handleMuscleSelection(
                        ref: ref,
                        multiple: multiple,
                        muscle: 'Delts',
                      ),
                      child: SvgPicture.asset(
                        'assets/muscles/back/Delta.svg',
                        color: getMuscleColor(ref, multiple, "Delts"),
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
                      onTap: () => handleMuscleSelection(
                        ref: ref,
                        multiple: multiple,
                        muscle: 'Triceps',
                      ),
                      child: SvgPicture.asset(
                        'assets/muscles/back/Tricep.svg',
                        color: getMuscleColor(ref, multiple, "Triceps"),
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
                      onTap: () => handleMuscleSelection(
                        ref: ref,
                        multiple: multiple,
                        muscle: 'Forearms',
                      ),
                      child: SvgPicture.asset(
                        'assets/muscles/back/Back forearm.svg',
                        color: getMuscleColor(ref, multiple, "Forearms"),
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
                      onTap: () => handleMuscleSelection(
                        ref: ref,
                        multiple: multiple,
                        muscle: 'Back',
                      ),
                      child: SvgPicture.asset(
                        'assets/muscles/back/Back.svg',
                        color: getMuscleColor(ref, multiple, "Back"),
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
                      onTap: () => handleMuscleSelection(
                        ref: ref,
                        multiple: multiple,
                        muscle: 'Lower Back',
                      ),
                      child: SvgPicture.asset(
                        'assets/muscles/back/Lower back.svg',
                        color: getMuscleColor(ref, multiple, "Lower Back"),
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
                      onTap: () => handleMuscleSelection(
                        ref: ref,
                        multiple: multiple,
                        muscle: 'Hamstrings',
                      ),
                      child: SvgPicture.asset(
                        'assets/muscles/back/Hamstring.svg',
                        color: getMuscleColor(ref, multiple, "Hamstrings"),
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
                      onTap: () => handleMuscleSelection(
                        ref: ref,
                        multiple: multiple,
                        muscle: 'Glutes',
                      ),
                      child: SvgPicture.asset(
                        'assets/muscles/back/Ass.svg',
                        color: getMuscleColor(ref, multiple, "Glutes"),
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
                      onTap: () => handleMuscleSelection(
                        ref: ref,
                        multiple: multiple,
                        muscle: 'Calves',
                      ),
                      child: SvgPicture.asset(
                        'assets/muscles/back/Calfs.svg',
                        color: getMuscleColor(ref, multiple, "Calves"),
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
