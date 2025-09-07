import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/logic/models/workout_model.dart';
import 'package:neurofit_app/features/workout/presentation/dialogs/close_workout_dialog.dart';
import 'package:neurofit_app/features/workout/presentation/dialogs/paused_workout_dialog.dart';
import 'package:neurofit_app/features/workout/presentation/sheets/all_workout_exercises_MBS.dart';
import 'package:neurofit_app/shared/presentation/widgets/widgets.dart';
import 'package:neurofit_app/features/workout/presentation/widgets/workout_widgets.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:video_player/video_player.dart';

class StartWorkoutScreen extends StatefulWidget {
  const StartWorkoutScreen({
    required this.workout,
    super.key,
  });

  final WorkoutModel workout;

  @override
  State<StartWorkoutScreen> createState() => _StartWorkoutScreenState();
}

class _StartWorkoutScreenState extends State<StartWorkoutScreen> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final StopWatchTimer _countdownTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromMinute(1) +
        StopWatchTimer.getMilliSecFromSecond(30),
  );

  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.onStartTimer();
    _videoPlayerController = VideoPlayerController.asset(
      'assets/videos/PushUp.mp4',
    );
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  late int exerciseCounter = 0;
  late int setsCounter = 0;
  late int workoutLength;
  late String exerciseName;
  late String exerciseEquipment;
  late String exerciseMuscleGroup;
  late int exerciseReps;
  late double? exerciseWeight;
  late int exerciseSets;

  void _onSetCompleted() {
    setState(() {
      setsCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    workoutLength = widget.workout.exercises.length;
    exerciseName = widget.workout.exercises[exerciseCounter].name;
    exerciseEquipment = widget.workout.exercises[exerciseCounter].equipment;
    exerciseMuscleGroup =
        widget.workout.exercises[exerciseCounter].muscleGroup;

    exerciseSets = widget.workout.exercises[exerciseCounter].sets.length;

    int currentIndex =
        (setsCounter >= exerciseSets) ? exerciseSets - 1 : setsCounter;

    exerciseReps =
        widget.workout.exercises[exerciseCounter].sets[currentIndex].reps;
    exerciseWeight =
        widget.workout.exercises[exerciseCounter].sets[currentIndex].weight;

    return Scaffold(
      backgroundColor: kWorkoutPageColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            closeWorkoutDialog(context, _stopWatchTimer, _countdownTimer);
          },
          icon: Icon(
            Icons.close,
            color: kBlack,
          ),
        ),
        backgroundColor: kWhite,
        elevation: 1,
        shadowColor: kBlack,
        title: Text(
          "${exerciseCounter + 1} / $workoutLength",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 15),
            onPressed: () {
              _stopWatchTimer.onStopTimer();
              pausedWorkoutDialog(context, _stopWatchTimer, _countdownTimer);
            },
            icon: Icon(
              Icons.pause,
              color: kBlack,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(15),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: AnimatedProgressBar(
              currentStep: exerciseCounter + 1,
              maxSteps: workoutLength,
              color: kBlue,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(12),
                ),
                // child: FutureBuilder(
                //   future: _videoPlayerController.initialize(),
                //   builder: (context, snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return const CircularProgressIndicator(color: kBlue);
                //     } else if (snapshot.connectionState ==
                //         ConnectionState.done) {
                //       _videoPlayerController.play();
                //       _videoPlayerController.setLooping(true);

                //       return Container(
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(12),
                //             boxShadow: kContainerElevation),
                //         clipBehavior: Clip.hardEdge,
                //         child: AspectRatio(
                //           aspectRatio:
                //               _videoPlayerController.value.aspectRatio,
                //           child: VideoPlayer(_videoPlayerController),
                //         ),
                //       );
                //     } else {
                //       return const Text("Error loading video");
                //     }
                //   },
                // )
              ),
              Text(
                exerciseName,
                style: kTitleCard,
              ),
              SizedBox(
                height: 15,
              ),
              Wrap(
                spacing: 8,
                children: [
                  WorkoutCardChip(label: exerciseMuscleGroup),
                  WorkoutCardChip(label: 'Equipment: $exerciseEquipment'),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 25, bottom: 25),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: kContainerElevation),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Sets',
                              style: TextStyle(
                                color: kTextGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '$setsCounter / $exerciseSets',
                              style: TextStyle(
                                color: kBlack,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Reps',
                              style: TextStyle(
                                color: kTextGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '$exerciseReps',
                              style: TextStyle(
                                color: kBlack,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Weight (lbs)',
                              style: TextStyle(
                                color: kTextGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '$exerciseWeight',
                              style: TextStyle(
                                color: kBlack,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AnimatedProgressBar(
                      currentStep: setsCounter,
                      maxSteps: exerciseSets,
                      color: kGreen,
                    ),
                    WorkoutSetWidget(
                      setsCounter: setsCounter,
                      exerciseSets: exerciseSets,
                      onSetCompleted: _onSetCompleted,
                      countdownTimer: _countdownTimer,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                      backgroundColor: kWhite,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: exerciseCounter == 0
                        ? null
                        : () {
                            setState(() {
                              exerciseCounter--;
                            });
                          },
                    label: Text(
                      'Previous',
                      style: TextStyle(
                        color: kBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: kBlack,
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                      backgroundColor: kWhite,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => allWorkoutExercisesMBS(
                        context, widget.workout.exercises),
                    label: Text(
                      'Exercises',
                      style: TextStyle(
                        color: kBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    icon: Icon(
                      Icons.list,
                      color: kBlack,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: MediaQuery.of(context).size.height * 0.1,
        color: kWhite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.timer_outlined,
                  size: 25,
                  color: kBlue,
                ),
                SizedBox(
                  width: 15,
                ),
                StreamBuilder<int>(
                  stream: _stopWatchTimer.rawTime,
                  initialData: _stopWatchTimer.rawTime.value,
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    );
                  },
                ),
              ],
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                backgroundColor: kBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (exerciseCounter == 3) {
                  Navigator.pop(context);
                } else {
                  setState(() {
                    exerciseCounter++;
                    setsCounter = 0;
                  });
                }
              },
              label: Text(
                exerciseCounter == 3 ? 'Finish Workout' : 'Next Exercise',
                style: TextStyle(
                  color: kWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              icon: exerciseCounter == 3
                  ? null
                  : Icon(
                      Icons.arrow_forward_ios,
                      color: kWhite,
                    ),
              iconAlignment: IconAlignment.end,
            ),
          ],
        ),
      ),
    );
  }
}

class WorkoutSetWidget extends StatefulWidget {
  final int setsCounter;
  final int exerciseSets;
  final VoidCallback onSetCompleted;
  final StopWatchTimer countdownTimer;

  const WorkoutSetWidget({
    super.key,
    required this.setsCounter,
    required this.exerciseSets,
    required this.onSetCompleted,
    required this.countdownTimer,
  });

  @override
  State<WorkoutSetWidget> createState() => _WorkoutSetWidgetState();
}

class _WorkoutSetWidgetState extends State<WorkoutSetWidget> {
  bool _isResting = false;

  final int _totalTimeMs = 90000;

  @override
  void dispose() {
    widget.countdownTimer.dispose();
    super.dispose();
  }

  void _startRest() {
    setState(() {
      _isResting = true;
    });

    widget.countdownTimer.onResetTimer();
    widget.countdownTimer.onStartTimer();

    widget.countdownTimer.rawTime.listen((value) {
      if (value <= 0 && _isResting) {
        _endRest();
      }
    });
  }

  void _endRest() {
    setState(() {
      _isResting = false;
      widget.countdownTimer.onStopTimer();
      widget.countdownTimer.onResetTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isResting ? _buildRestContainer() : _buildCompleteSetContainer();
  }

  Widget _buildRestContainer() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder<int>(
            stream: widget.countdownTimer.rawTime,
            initialData: widget.countdownTimer.rawTime.value,
            builder: (context, snapshot) {
              final value = snapshot.data!;
              final displayTime = StopWatchTimer.getDisplayTime(
                value,
                hours: false,
                minute: true,
                second: true,
                milliSecond: false,
              );

              final progress = value / _totalTimeMs;

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.timer, color: Colors.amber),
                      SizedBox(width: 10),
                      Text(
                        '$displayTime Rest',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  AnimatedProgressBar(
                    currentStep: (progress * 100).toInt(),
                    maxSteps: 100,
                    color: Colors.amber,
                  ),
                  SizedBox(height: 15),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side:
                          BorderSide(color: Colors.amber.shade700, width: 1.5),
                      foregroundColor: Colors.amber.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _endRest, // skip rest
                    child: Text("Skip Rest"),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ✅ Complete Set Container
  Widget _buildCompleteSetContainer() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: double.infinity,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          backgroundColor: widget.setsCounter >= widget.exerciseSets
              ? Colors.grey
              : Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: widget.setsCounter >= widget.exerciseSets
            ? null
            : () {
                widget.onSetCompleted(); // 🔥 tell parent to increment counter
                _startRest(); // start rest timer
              },
        label: Text(
          widget.setsCounter >= widget.exerciseSets
              ? 'All Sets Completed'
              : 'Complete Set ${widget.setsCounter + 1}',
          softWrap: false,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        icon: const Icon(Icons.check, color: Colors.white, size: 25),
      ),
    );
  }
}
