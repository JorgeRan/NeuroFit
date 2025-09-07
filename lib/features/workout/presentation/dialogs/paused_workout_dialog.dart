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

Future<dynamic> pausedWorkoutDialog(
  BuildContext context,
  StopWatchTimer stopWatchTimer,
  StopWatchTimer countDownTimer,
) {
  return showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.7),
    builder: (_) => Consumer(
      builder: (context, ref, _) {
        return StatefulBuilder(
          builder: (context, setState) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            child: LayoutBuilder(
              builder: (context, constraints) => SizedBox(
                height: MediaQuery.of(context).size.height * 0.80,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Workout Paused',
                        style: kPageTitle.copyWith(fontSize: 30),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Current Time: ',
                              style: TextStyle(color: kWhite, fontSize: 18,),
                            ),
                            StreamBuilder<int>(
                              stream: stopWatchTimer.rawTime,
                              initialData: stopWatchTimer.rawTime.value,
                              builder: (context, snapshot) {
                                final value = snapshot.data!;
                                final displayTime = StopWatchTimer.getDisplayTime(
                                  value,
                                  hours: false,
                                  minute: true,
                                  second: true,
                                  milliSecond: false,
                                );
                        
                                return Text(
                                  displayTime,
                                  style: TextStyle(
                                    fontSize: 18,
                                    
                                    color: kWhite,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 30),
                            backgroundColor: kBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            countDownTimer.onStartTimer();
                            stopWatchTimer.onStartTimer();
                            Navigator.pop(context);
                          },
                          label: Text(
                            'Resume Workout',
                            style: TextStyle(
                              color: kWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          icon: Icon(
                            Icons.play_arrow_outlined,
                            color: kWhite,
                            size: 35,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 17, horizontal: 30),
                            backgroundColor: kWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              Navigator.of(context)
                                ..pop()
                                ..pop();
                              countDownTimer.onStartTimer();
                              stopWatchTimer.onStartTimer();
                            });
                          },
                          label: Text(
                            'Exit Workout',
                            style: TextStyle(
                              color: kBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ],
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
