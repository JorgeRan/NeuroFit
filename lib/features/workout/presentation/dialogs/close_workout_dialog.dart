import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/data/providers/create_workout_providers.dart';
import 'package:neurofit_app/features/workout/presentation/widgets/workout_widgets.dart';
import 'package:cart_stepper/cart_stepper.dart';
import 'package:neurofit_app/features/workout/logic/models/workout_exercise_model.dart';
import 'package:neurofit_app/features/workout/presentation/views/create-workout-views/add_exercise_view.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

final tempSetsProvider = StateProvider<Map<String, int>>((ref) => {});

Future<dynamic> closeWorkoutDialog(
  BuildContext context,
  StopWatchTimer stopWatchTimer,
  StopWatchTimer countdonwTimer,
) {
  return showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.7),
    builder: (_) => Consumer(
      builder: (context, ref, _) {

        stopWatchTimer.onStopTimer();
        countdonwTimer.onStopTimer();

        return StatefulBuilder(
          builder: (context, setState) => Dialog(
            backgroundColor: kWhite,
            
            insetPadding: EdgeInsets.zero,
            child: LayoutBuilder(
              builder: (context, constraints) => SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Exit Workout?',
                          style:
                              kPageTitle.copyWith(fontSize: 30, color: kBlack),
                        ),
                        Text(
                          'Your progress will not be saved',
                          style: TextStyle(
                            color: kDarkGrey,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 17, horizontal: 30),
                                  backgroundColor: kButtonGrey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  stopWatchTimer.onStartTimer();
                                  countdonwTimer.onStartTimer();
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: kDarkGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 17, horizontal: 30),
                                  backgroundColor: kRed,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    Navigator.of(context)
                                      ..pop()
                                      ..pop();
                                  });
                                },
                                label: Text(
                                  'Exit',
                                  style: TextStyle(
                                    color: kWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
