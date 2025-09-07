import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/data/providers/create_workout_providers.dart';
import 'package:neurofit_app/shared/presentation/widgets/widgets.dart';
import 'package:neurofit_app/features/workout/presentation/widgets/workout_widgets.dart';

final selectedRoutineGoalProvider = StateProvider<String>((ref) => '');

final List days = [
  2,
  3,
  4,
  5,
  6,
  7,
];
final selectedDayProvider = StateProvider<int>(
  (ref) => 0,
);

class DaysView extends ConsumerWidget {
  const DaysView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRoutineGoal = ref.watch(selectedRoutineGoalProvider);
    final selectedDay = ref.watch(selectedDayProvider);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select how many days you\'ll work out each week.',
            style: kNormalText,
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 15,
              children: days.map(
                (day) {
                  bool isSelected = day == selectedDay;

                  return GestureDetector(
                    onTap: () {
                      ref.read(selectedDayProvider.notifier).state = day;
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: kWhite,
                        border:
                            Border.all(color: isSelected ? kBlue : kTextGrey, width: isSelected ? 2 : 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '$day days',
                          style: kNormalText.copyWith(
                               color:  isSelected ? kBlue : kBlack),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
          ),
        ],
      ),
    );
  }
}
