import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/workout/data/providers/create_routine_providers.dart';
import 'package:neurofit_app/features/workout/presentation/screens/create_routine_screen.dart';
import 'package:neurofit_app/features/workout/presentation/screens/exercise_screen.dart';
import 'package:neurofit_app/features/workout/presentation/screens/routine_screen.dart';
import 'package:neurofit_app/features/workout/presentation/screens/start_workout_screen.dart';
import 'package:neurofit_app/features/workout/presentation/widgets/workout_widgets.dart';
import 'package:neurofit_app/shared/presentation/widgets/widgets.dart';
import 'package:neurofit_app/features/workout/presentation/screens/create_workout_screen.dart';
import 'package:neurofit_app/shared/presentation/interactive_body.dart';
import 'package:neurofit_app/features/workout/data/providers/create_workout_providers.dart';
import 'package:neurofit_app/features/workout/presentation/screens/workout_screen.dart';

final filterProvider = StateProvider<bool>((ref) => false);

Set routineWorkouts = {};

class MyRoutinesScreens extends ConsumerWidget {
  const MyRoutinesScreens({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allRoutines = ref.watch(allRoutinesProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            ref.read(createRoutineProvider.notifier).state = 0;
            ref.read(selectedMuscleGroupsProvider.notifier).state = [];
            ref.read(isFrontProvider.notifier).state = true;

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const CreateRoutineScreen();
            }));
          },
          icon: Icon(
            Icons.add,
            color: kWhite,
          ),
          label: Text(
            'Create Routine',
            style:
                kTitleCard.copyWith(color: kWhite, fontWeight: FontWeight.bold),
          ),
          backgroundColor: kBlue,
        ),
        backgroundColor: kWorkoutPageColor,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: kWhite,
          elevation: 1,
          shadowColor: kBlack,
          actions: [
            Material(
              color: Colors.transparent,
              child: Text(
                'My Routines',
                style: kPageTitle.copyWith(color: kBlack),
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
          leading: IconButton(
            color: kBlack,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBar(
                  trailing: <Widget>[
                    Tooltip(
                      message: 'Change brightness mode',
                      child: IconButton(
                        onPressed: () {
                          if (ref.watch(filterProvider) == false) {
                            ref.read(filterProvider.notifier).state = true;
                          } else {
                            ref.read(filterProvider.notifier).state = false;
                          }
                        },
                        icon: const Icon(Icons.tune_rounded),
                        selectedIcon: const Icon(Icons.brightness_2_outlined),
                      ),
                    ),
                  ],
                  hintStyle:
                      WidgetStateProperty.all(TextStyle(color: Colors.grey)),
                  hintText: 'Search workout, muscles or equipment',
                  side: WidgetStateProperty.all(BorderSide(
                    color: kFieldBorder,
                    width: 1,
                  )),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
                  elevation: WidgetStateProperty.all(0),
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  onChanged: (value) => print('Search: $value'),
                ),
                if (ref.watch(filterProvider))
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: kBlack,
                  ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'All Routines',
                  style: kTitleCard,
                ),
                Column(
                  children: allRoutines.map((routine) {
                    for (var day in routine.workouts.values) {
                      for (var w in day) {
                        routineWorkouts.add(w);
                      }
                    }

                    var workoutCount = routineWorkouts.length;
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      child: Card(
                        color: kWhite,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RoutineScreen(
                                    routine: routine,
                                    workoutCount: workoutCount,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(routine.name,
                                                style: kTitleCard),
                                          ),
                                          Text(
                                            '$workoutCount Workouts • ${routine.workouts.length} Days/Week',
                                            style: const TextStyle(
                                              color: kTextGrey,
                                              fontSize: 15,
                                            ),
                                          ),
                                          RoutineCardChip(label: routine.goal),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Progress',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                '75%',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: AnimatedProgressBar(
                                                currentStep: 4,
                                                maxSteps: 6,
                                                color: kBlue),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                RoutineCardButtons(
                                  label: 'Start',
                                  icon: Icon(
                                    Icons.play_arrow_outlined,
                                    size: 27,
                                    color: kBlue,
                                  ),
                                  onTap: () {
                                    print("Start");
                                  },
                                ),
                                RoutineCardButtons(
                                  label: 'Edit',
                                  icon: Image.asset(
                                    'assets/icons/Edit_icon.png',
                                    height: 27,
                                  ),
                                  onTap: () {
                                    print('Edit');
                                  },
                                ),
                                RoutineCardButtons(
                                  label: 'Delete',
                                  icon: Icon(
                                    Icons.delete_outline,
                                    size: 27,
                                    color: kRed,
                                  ),
                                  onTap: () {
                                    print('Delete');
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoutineCardButtons extends StatelessWidget {
  const RoutineCardButtons({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final Widget icon;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: kFieldBorder),
            right: BorderSide(color: kFieldBorder),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              SizedBox(
                width: 10,
              ),
              Text(
                label,
                style: TextStyle(
                  color: label == 'Start'
                      ? kBlue
                      : label == 'Delete'
                          ? kRed
                          : kTextGrey,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class EditSquareOutlined extends StatelessWidget {
  final double size;
  final Color iconColor;
  final Color borderColor;

  const EditSquareOutlined({
    super.key,
    this.size = 24.0,
    this.iconColor = Colors.black,
    this.borderColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size * 0.2), // spacing inside the square
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        Icons.edit_outlined,
        size: size,
        color: iconColor,
      ),
    );
  }
}
