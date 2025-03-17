import 'package:break_time/providers/auth_provider.dart';
import 'package:break_time/utiles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/onboarding_provider.dart';
import '../widget/button.dart';
import '../widget/checkbox.dart';
import '../widget/custom_text.dart';
import '../widget/custom_textfield.dart';
import '../widget/reusable_widget.dart';
import '../widget/size_box.dart';
import '../utiles/colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
  
    final onboardingProvider =
        Provider.of<OnboardingProvider>(context, listen: false);
  
    onboardingProvider.reset();
 
    _dayController.text = onboardingProvider.day;
    _monthController.text = onboardingProvider.month;
    _yearController.text = onboardingProvider.year;

    _dayController
        .addListener(() => onboardingProvider.updateDay(_dayController.text));
    _monthController.addListener(
        () => onboardingProvider.updateMonth(_monthController.text));
    _yearController
        .addListener(() => onboardingProvider.updateYear(_yearController.text));
  }

  void continueBtn(OnboardingProvider onboardingProvider) async {
    if (onboardingProvider.completedSteps < 4) {
      showToast("Please complete all steps.");
    } else {
      final authProvider =
          Provider.of<AuthenticationProvider>(context, listen: false);
      final user = authProvider.user;
      if (user != null) {
        await onboardingProvider.submitOnboarding(user.uid);
        if (onboardingProvider.errorMessage == null) {
          Navigator.pushReplacementNamed(context, Constants.homeRoute);
        } else {
          showToast(onboardingProvider.errorMessage!);
        }
      } else {
        showToast("User not logged in. Please log in again.");
        Navigator.pushReplacementNamed(context, Constants.loginRoute);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
      builder: (context, onboardingProvider, child) {
        return Scaffold(
          backgroundColor: AppColor.backgroundColors,
          appBar: AppBar(backgroundColor: AppColor.backgroundColors),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: onboardingProvider.completedSteps / 4,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(50),
                  backgroundColor: const Color(0xFFD8DAE5),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xFF3030D6)),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Height(24),
                        sectionHeader('Skills', size: 17.00),
                        CustomText(
                            text: "Tell us a bit more about your skills"),
                        const Height(32),
                        sectionHeader(
                            'How many of these tasks have you done before? (select all that apply)'),
                        const Height(12),
                        ..._buildTaskCheckboxes(onboardingProvider),
                        const Height(24),
                        sectionHeader('Do you have your own smartphone?'),
                        const Height(12),
                        ..._buildRadioButtons(
                          onboardingProvider.hasSmartphone,
                          (value) =>
                              onboardingProvider.updateHasSmartphone(value),
                        ),
                        const Height(24),
                        sectionHeader('Have you ever used Google Maps?'),
                        const Height(12),
                        ..._buildRadioButtons(
                          onboardingProvider.usedGoogleMaps,
                          (value) =>
                              onboardingProvider.updateUsedGoogleMaps(value),
                        ),
                        const Height(24),
                        sectionHeader('Date of birth'),
                        const Height(12),
                        _buildDateFields(),
                        const Height(20),
                      ],
                    ),
                  ),
                ),
                ContinueButton(
                  text: 'Continue',
                  isValid: onboardingProvider.completedSteps == 4,
                  isLoading: onboardingProvider.isLoading,
                  onTap: () => continueBtn(onboardingProvider),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildRadioButtons(bool? value, Function(bool?) onChanged) {
    return [
      Row(
        children: [
          _buildRadio('Yes', value == true,
              (newValue) => onChanged(newValue == true ? true : null)),
          const Widths(16),
          _buildRadio('No', value == false,
              (newValue) => onChanged(newValue == true ? false : null)),
        ],
      )
    ];
  }

  Widget _buildRadio(String title, bool value, Function(bool?) onChanged) {
    return CheckBox(value: value, text: title, onChanged: onChanged);
  }

  List<Widget> _buildTaskCheckboxes(OnboardingProvider provider) {
    const tasks = [
      'Cutting vegetables',
      'Sweeping',
      'Mopping',
      'Cleaning bathrooms',
      'Laundry',
      'Washing dishes',
      'None of the above',
    ];

    return [
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 5.0,
        ),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: CheckBox(
              text: tasks[index],
              value: provider.taskChecks[index],
              borderRadius: 4.00,
              onChanged: (value) => provider.updateTaskCheck(index, value),
            ),
          );
        },
      ),
    ];
  }

  Widget _buildDateFields() {
    return Row(
      children: [
        customTextField(
          hintText: 'DD',
          width: 75,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: _dayController,
        ),
        const Widths(12),
        customTextField(
          hintText: 'MM',
          width: 75,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: _monthController,
        ),
        const Widths(12),
        customTextField(
          hintText: 'YYYY',
          width: 75,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: _yearController,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }
}
