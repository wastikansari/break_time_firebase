import 'package:break_time/models/onboarding_model.dart';
import 'package:break_time/services/onboarding_services.dart';
import 'package:flutter/material.dart';

class OnboardingProvider with ChangeNotifier {
  final List<bool> _taskChecks = List.filled(7, false);
  bool? _hasSmartphone;
  bool? _usedGoogleMaps;
  String _day = '';
  String _month = '';
  String _year = '';
  bool _isLoading = false;
  String? _errorMessage;

  final OnboardingService _onboardingService = OnboardingService();

  List<bool> get taskChecks => _taskChecks;
  bool? get hasSmartphone => _hasSmartphone;
  bool? get usedGoogleMaps => _usedGoogleMaps;
  String get day => _day;
  String get month => _month;
  String get year => _year;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool get tasksCompleted => _taskChecks.contains(true);
  bool get smartphoneCompleted => _hasSmartphone != null;
  bool get mapsCompleted => _usedGoogleMaps != null;
  bool get dobCompleted => _day.isNotEmpty && _month.isNotEmpty && _year.isNotEmpty;

void reset() {
  _taskChecks.fillRange(0, _taskChecks.length, false);
  _hasSmartphone = null;
  _usedGoogleMaps = null;
  _day = '';
  _month = '';
  _year = '';
  _isLoading = false;
  _errorMessage = null;
  notifyListeners();
}

  int get completedSteps => [
        tasksCompleted,
        smartphoneCompleted,
        mapsCompleted,
        dobCompleted,
      ].where((c) => c).length;

  void updateTaskCheck(int index, bool? value) {
    if (index == 6) {
      for (var i = 0; i < _taskChecks.length; i++) {
        _taskChecks[i] = i == 6;
      }
    } else {
      _taskChecks[index] = value ?? false;
      _taskChecks[6] = false;
    }
    notifyListeners();
  }

  void updateHasSmartphone(bool? value) {
    _hasSmartphone = value;
    notifyListeners();
  }

  void updateUsedGoogleMaps(bool? value) {
    _usedGoogleMaps = value;
    notifyListeners();
  }

  void updateDay(String day) {
    _day = day;
    notifyListeners();
  }

  void updateMonth(String month) {
    _month = month;
    notifyListeners();
  }

  void updateYear(String year) {
    _year = year;
    notifyListeners();
  }

  Future<void> submitOnboarding(String uid) async {
    _isLoading = true;
    notifyListeners();

    try {
      final tasks = [
        'Cutting vegetables',
        'Sweeping',
        'Mopping',
        'Cleaning bathrooms',
        'Laundry',
        'Washing dishes',
        'None of the above',
      ];
      List<String> selectedSkills = [];
      for (int i = 0; i < _taskChecks.length; i++) {
        if (_taskChecks[i]) {
          selectedSkills.add(tasks[i]);
        }
      }

      final onboardModel = OnboardingModel(
        skills: selectedSkills,
        hasSmartphone: _hasSmartphone ?? false,
        usedGoogleMaps: _usedGoogleMaps ?? false,
        dob: '$_day/$_month/$_year',
      );

      await _onboardingService.submitOnboarding(uid, onboardModel);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}