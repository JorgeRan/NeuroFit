import 'package:flutter/material.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:neurofit_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:neurofit_app/features/auth/presentation/screens/signUp_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingCard extends StatelessWidget {
  final Widget iconCard;
  final String header;
  final String body;
  const OnboardingCard({
    required this.iconCard,
    required this.header,
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kCardBlue,
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconCard,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                header,
                style: TextStyle(
                    color: kWhite, fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              body,
              style: TextStyle(
                color: kWhite,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class AccountTextField extends ConsumerWidget {
  final String header;
  final String hintText;
  final bool isPassword;
  final Function(String) onChanged;
  final StateProvider<String?> provider;
  final int questionIndex;

  const AccountTextField({
    required this.header,
    required this.hintText,
    required this.isPassword,
    required this.onChanged,
    super.key,
    required this.provider,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 5),
          child: Text(
            header,
            style: kParagraphText,
            textAlign: TextAlign.start,
          ),
        ),
        CustomTextField(
          provider,
          hintText,
          isPassword,
          '',
          false,
          header,
          questionIndex,
        ),
      ],
    );
  }
}

class QuestionsCustomTextField extends ConsumerWidget {
  final String hintText;
  final String suffixText;
  final bool isNumber;
  final StateProvider<String?> provider;
  final bool isUnanswered;
  final String errorLabel;

  const QuestionsCustomTextField(this.hintText, this.suffixText, this.isNumber,
      this.provider, this.isUnanswered, this.errorLabel,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = ref.watch(provider); 
    final controller = TextEditingController(text: text)
      ..selection = TextSelection.collapsed(offset: text!.length);

    if (hintText == 'cm') {
      ref.read(selectedHeightProvider.notifier).state = '';
    }
    int questionNumber = 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          width: double.infinity,
          height: 48,
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.next,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            onChanged: (val) {
              if (errorLabel == 'Age') {
                questionNumber = 0;
              } else if (errorLabel == 'Height') {
                questionNumber = 2;
              } else if (errorLabel == 'Weight') {
                questionNumber = 3;
              }
              ref
                  .read(unansweredQuestionsProvider.notifier)
                  .state
                  .remove(questionNumber);
              ref.read(provider.notifier).state = val;
            },
            decoration: InputDecoration(
              suffixText: suffixText,
              suffixStyle: kParagraphText,
              fillColor: kWhite,
              hintText: hintText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isUnanswered ? Colors.red : kLightGrey, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isUnanswered ? Colors.red : kFieldBorder,
                    width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
        if (isUnanswered)
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(
              'Please provide a valid $errorLabel',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}

class CustomTextField extends ConsumerWidget {
  final String hintText;
  final bool isPassword;
  final String suffixText;
  final bool isNumber;
  final String errorLabel;
  final StateProvider<String?> provider;
  final int questionIndex;

  const CustomTextField(
    this.provider,
    this.hintText,
    this.isPassword,
    this.suffixText,
    this.isNumber,
    this.errorLabel,
    this.questionIndex, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUnanswered =
        ref.watch(unansweredAccountQuestions).contains(questionIndex);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          
          decoration: const BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          width: double.infinity,
          height: 48,
          child: TextField(
            textInputAction: TextInputAction.next,
            obscureText: isPassword,
            keyboardType: isPassword
                ? isNumber
                    ? TextInputType.number
                    : TextInputType.text
                : TextInputType.emailAddress,
            onChanged: (value) {
              ref.read(provider.notifier).state = value;

              ref.read(unansweredAccountQuestions.notifier).update((state) {
                final newState = {...state};
                newState.remove(questionIndex);
                return newState;
              });
            },
            decoration: InputDecoration(
              suffixText: suffixText,
              suffixStyle: kParagraphText,
              fillColor: kWhite,
              hintText: hintText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isUnanswered ? Colors.red : kFieldBorder,
                    width: 1.0),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isUnanswered ? Colors.red : kFieldBorder,
                    width: 2.0),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
        if (isUnanswered)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              'Please provide a valid $errorLabel',
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}

class GoogleAppleButton extends StatelessWidget {
  GoogleAppleButton({
    required this.appLogin,
    required this.signInFunction,
    super.key,
  });

  final String appLogin;
  final Function() signInFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: signInFunction,
      child: Container(
        width: 112,
        height: 55,
        decoration: BoxDecoration(
          color: appLogin == 'google' ? kWhite : kBlack,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Transform.scale(
            scale: 0.6,
            child: Image.asset(
              'assets/images/$appLogin.png',
            )),
      ),
    );
  }
}

class BuildHeightInput extends ConsumerWidget {
  final String? selectedHeightUnit;
  final Function(String) onChanged;

  const BuildHeightInput(this.selectedHeightUnit, this.onChanged, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (selectedHeightUnit == 'ft / in') {
      return Row(
        children: [
          Expanded(
            child: QuestionsCustomTextField(
                'ft',
                'ft',
                true,
                selectedFtProvider,
                ref.watch(unansweredQuestionsProvider).contains(2),
                'Height'),
          ),
          SizedBox(width: 10),
          Expanded(
            child: QuestionsCustomTextField(
                'in',
                'in',
                true,
                selectedInProvider,
                ref.watch(unansweredQuestionsProvider).contains(2),
                'Height'),
          ),
        ],
      );
    }

    return QuestionsCustomTextField(
        'Enter height',
        'cm',
        true,
        selectedHeightProvider,
        ref.watch(unansweredQuestionsProvider).contains(2),
        'Height');
  }
}

Widget buildLabel(String title) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0, bottom: 5),
    child: Text(title, style: kQuestionsText),
  );
}



Widget buildUnitTextField({
  required String hint,
  required String suffix,
  required Function(String) onChanged,
}) {
  return Container(
    height: 48,
    decoration: BoxDecoration(
      color: kWhite,
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        suffixText: suffix,
        suffixStyle: kParagraphText,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD1D5DB), width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD1D5DB), width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}

Widget buildDropdown({
  required String hint,
  required String? value,
  required List<String> items,
  required Function(String?) onChanged,
}) {
  return DropdownButtonFormField2<String>(
    isExpanded: true,
    value: value,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    ),
    hint: Text(hint, style: TextStyle(fontSize: 14)),
    items: items
        .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: kParagraphText),
            ))
        .toList(),
    validator: (val) => val == null ? 'Select unit' : null,
    onChanged: onChanged,
    onSaved: (_) {},
    buttonStyleData: ButtonStyleData(padding: EdgeInsets.only(right: 8)),
    iconStyleData: IconStyleData(
      icon: Icon(Icons.arrow_drop_down, color: Colors.black45),
      iconSize: 24,
    ),
    dropdownStyleData: DropdownStyleData(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    menuItemStyleData:
        MenuItemStyleData(padding: EdgeInsets.symmetric(horizontal: 16)),
  );
}

class AnimatedProgressBar extends StatefulWidget {
  final int currentStep;
  final int maxSteps;

  const AnimatedProgressBar({
    super.key,
    required this.currentStep,
    required this.maxSteps,
  });

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  double _oldProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animateToProgress();
  }

  @override
  void didUpdateWidget(covariant AnimatedProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _oldProgress = oldWidget.currentStep / oldWidget.maxSteps;
    _animateToProgress();
  }

  void _animateToProgress() {
    final newProgress = widget.currentStep / widget.maxSteps;
    _animation = Tween<double>(
      begin: _oldProgress,
      end: newProgress,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LinearProgressIndicator(
          value: _animation.value,
          minHeight: 5,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(kBlue),
        ),
      ),
    );
  }
}

class RadioButtons extends ConsumerWidget {
  const RadioButtons({
    super.key,
    required this.filter,
    required this.provider,
    required this.questionIndex,
  });

  final List<dynamic> filter;
  final StateProvider provider;
  final int questionIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(provider);

    return Column(
      children: filter.map((item) {
        return RadioListTile<dynamic>(
          value: item.label,
          groupValue: selectedItem,
          onChanged: (val) {
            ref.read(provider.notifier).state = val;
            final current = ref.read(unansweredQuestionsProvider);
            ref.read(unansweredQuestionsProvider.notifier).state = {
              ...current..remove(questionIndex),
            };
          },
          title: Text(item.label, style: kParagraphText),
          activeColor: kBlue,
        );
      }).toList(),
    );
  }
}

class AnimationQuestions extends StatelessWidget {
  const AnimationQuestions({
    super.key,
    required int previousCounter,
    required this.counter,
    required this.child,
  }) : _previousCounter = previousCounter;

  final int _previousCounter;
  final int counter;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(_previousCounter < counter ? 0.5 : -0.5, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            )),
            child: child,
          ),
        );
      },
      child: KeyedSubtree(
        key: ValueKey(counter),
        child: child,
      ),
    );
  }
}

class SingleSelectQuestion extends ConsumerWidget {
  const SingleSelectQuestion({
    super.key,
    required this.options,
    required this.onTap,
    required this.input,
    required this.questionIndex,
  });

  final List<Map<String, String>> options;
  final void Function(String) onTap;
  final String? input;
  final int questionIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unanswered = ref.watch(unansweredQuestionsProvider);
    final isUnanswered = unanswered.contains(questionIndex);

    return Column(
      children: options.map((level) {
        final isSelected = input == level['value'];
        return GestureDetector(
          onTap: () {
            onTap(level['value']!);

            ref.read(unansweredQuestionsProvider.notifier).update((state) {
              final updated = {...state};
              updated.remove(questionIndex);
              return updated;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? kBlue
                    : isUnanswered
                        ? Colors.red
                        : kFieldBorder,
                width: 2,
              ),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected ? kBlue : kFieldBorder,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          level['title'] ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            color: kBlack,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          level['description'] ?? '',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class MultipleChoiceQuestion extends ConsumerWidget {
  final String question;
  final List<dynamic> filter;
  final StateProvider<Set<String>> selectedItemsProvider;
  final bool haveIcon;
  final int questionIndex;

  const MultipleChoiceQuestion({
    super.key,
    required this.question,
    required this.filter,
    required this.selectedItemsProvider,
    required this.haveIcon,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItems = ref.watch(selectedItemsProvider);
    final unanswered =
        ref.watch(unansweredQuestionsProvider).contains(questionIndex);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 35),
        Text(question, style: kQuestionsText),
        const SizedBox(height: 5),
        const Text(
          "You can select more than one",
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 12,
          children: filter.map((item) {
            final label = item.label;
            final isSelected = selectedItems.contains(label);

            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : unanswered
                              ? Colors.red
                              : Colors.transparent)),
              child: FilterChip(
                elevation: 3,
                checkmarkColor: kWhite,
                labelStyle: kParagraphText.copyWith(
                  color: isSelected ? kWhite : kBlack,
                ),
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: kParagraphText.copyWith(
                        color: isSelected ? kWhite : kBlack,
                      ),
                    ),
                    const SizedBox(width: 6, height: 40),
                    if (haveIcon)
                      Icon(
                        item.icon,
                        size: 23,
                        color: isSelected ? kWhite : kBlack,
                      ),
                  ],
                ),
                backgroundColor: kWhite,
                selectedColor: kBlue,
                selected: isSelected,
                onSelected: (selected) {
                  final selectedNotifier =
                      ref.read(selectedItemsProvider.notifier);
                  final unansweredNotifier =
                      ref.read(unansweredQuestionsProvider.notifier);

                  if (selected) {
                    selectedNotifier.state = {...selectedNotifier.state, label};
                  } else {
                    selectedNotifier.state =
                        selectedNotifier.state.where((e) => e != label).toSet();
                  }

                  // Update unanswered tracking
                  if (selectedNotifier.state.isNotEmpty) {
                    unansweredNotifier.state = {...unansweredNotifier.state}
                      ..remove(questionIndex);
                  } else {
                    unansweredNotifier.state = {...unansweredNotifier.state}
                      ..add(questionIndex);
                  }
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class OptionsErrorMessage extends StatelessWidget {
  const OptionsErrorMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(
        'Please select an option',
        style: TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }
}

class MuscleChip extends StatelessWidget {
  const MuscleChip({
    super.key, required this.muscle,
  });

  final String muscle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, right: 10),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: kWorkoutPageColor),
      child: Text(
        muscle,
        style: TextStyle(color:kBlue, fontSize: 17),
      ),
    );
  }
}

