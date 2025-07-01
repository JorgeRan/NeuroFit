import 'package:flutter/material.dart';
import 'package:neurofit_app/constants.dart';
import 'package:neurofit_app/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/screens/onboarding/onboarding_screen.dart';

class BasicInfo extends ConsumerWidget {
  const BasicInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGender = ref.watch(selectedGenderProvider);
    final selectedHeightUnit = ref.watch(selectedHeightUnitProvider);
    final selectedWeightUnit = ref.watch(selectedWeightUnitProvider);
    ref.watch(selectedHeightProvider);

    List<String> heightUnits = [
      'cm',
      'ft / in',
    ];

    List<String> weightUnits = [
      'kg',
      'lbs',
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 5),
                child: Text(
                  'Age',
                  style: kQuestionsText,
                  textAlign: TextAlign.start,
                ),
              ),
              QuestionsCustomTextField(
                '',
                'years',
                true,
                selectedAgeProvider,
                ref.watch(unansweredQuestionsProvider).contains(0),
                'Age',
              ),
              SizedBox(
                height: 20,
              ),
              Text('Biological Sex', style: kQuestionsText),
              if (ref.watch(unansweredQuestionsProvider).contains(1))
                Text(
                  'Required',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              Row(
                children: [
                  Radio(
                    value: Gender.male,
                    groupValue: selectedGender,
                    onChanged: (val) {
                      ref.read(selectedGenderProvider.notifier).state = val;
                      final current = ref.read(unansweredQuestionsProvider);
                      ref.read(unansweredQuestionsProvider.notifier).state = {
                        ...current..remove(1),
                      };
                    },
                    activeColor: kBlue,
                  ),
                  Text('Male', style: kParagraphText),
                  SizedBox(width: 20),
                  Radio(
                    value: Gender.female,
                    groupValue: selectedGender,
                    onChanged: (val) {
                      ref.read(selectedGenderProvider.notifier).state = val;
                      final current = ref.read(unansweredQuestionsProvider);
                      ref.read(unansweredQuestionsProvider.notifier).state = {
                        ...current..remove(1),
                      };
                    },
                    activeColor: kBlue,
                  ),
                  Text('Female', style: kParagraphText),
                ],
              ),
              buildLabel('Height'),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: BuildHeightInput(
                      selectedHeightUnit,
                      (val) =>
                          ref.read(selectedHeightProvider.notifier).state = val,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: buildDropdown(
                      hint: 'cm / ft',
                      value: selectedHeightUnit,
                      items: heightUnits,
                      onChanged: (val) => ref
                          .read(selectedHeightUnitProvider.notifier)
                          .state = val!,
                    ),
                  ),
                ],
              ),
              buildLabel('Weight'),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: QuestionsCustomTextField(
                          selectedWeightUnit == 'kg'
                              ? 'e.g. 70 kg'
                              : 'e.g. 154 lbs',
                          selectedWeightUnit ?? '',
                          true,
                          selectedWeightProvider,
                          ref.watch(unansweredQuestionsProvider).contains(3),
                          'Weight')
                      // buildUnitTextField(
                      //   hint: selectedWeightUnit == 'kg'
                      //       ? 'e.g. 70 kg'
                      //       : 'e.g. 154 lbs',
                      //   suffix: selectedWeightUnit ?? '',
                      //   onChanged: (val) =>
                      //       ref.read(selectedWeightProvider.notifier).state = val,
                      // ),
                      ),
                  SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: buildDropdown(
                      hint: 'kg / lbs',
                      value: selectedWeightUnit,
                      items: weightUnits,
                      onChanged: (val) => ref
                          .read(selectedWeightUnitProvider.notifier)
                          .state = val,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    // SingleChildScrollView(
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text('Age'),
    //       TextField(
    //         decoration: InputDecoration(suffixText: 'years'),
    //         keyboardType: TextInputType.number,
    //         onChanged: (val) => ref.read(selectedAgeProvider.notifier).state = val,
    //       ),
    //       Text('Biological Sex'),
    //       Row(
    //         children: [
    //           Radio<Gender>(
    //             value: Gender.male,
    //             groupValue: selectedGender,
    //             onChanged: (val) => ref.read(selectedGenderProvider.notifier).state = val,
    //           ),
    //           Text('Male'),
    //           Radio<Gender>(
    //             value: Gender.female,
    //             groupValue: selectedGender,
    //             onChanged: (val) => ref.read(selectedGenderProvider.notifier).state = val,
    //           ),
    //           Text('Female'),
    //         ],
    //       ),
    //       // Add height & weight similarly...
    //     ],
    //   ),
    // );
  }
}
