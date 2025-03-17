import 'dart:async';
import 'package:flutter/material.dart';
import '../services/break_service.dart';
import '../models/break_model.dart';

enum BreakState { active, confirming, ended }

class BreakProvider with ChangeNotifier {
  BreakModel? _breakData;
  int _remainingTime = 0;
  BreakState _state = BreakState.ended;
  Timer? _timer;
  bool _isLoading = false;
  String? _errorMessage;

  BreakModel? get breakData => _breakData;
  int get remainingTime => _remainingTime;
  BreakState get state => _state;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final BreakService _breakService = BreakService();

  void reset() {
    _remainingTime = 0;
    _timer?.cancel();
    _state = BreakState.ended;
    notifyListeners();
  }

  Future<void> fetchBreakData(String uid) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      _breakData = await _breakService.fetchBreakData(uid);
      if (_breakData != null) {
        _remainingTime = _breakData!.duration;
        _state = BreakState.active;
        startTimer();
      } else {
        _state = BreakState.ended;
      }
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _state = BreakState.ended;
    }

    _isLoading = false;
    notifyListeners();
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        notifyListeners();
      } else {
        _timer?.cancel();
        _state = BreakState.ended;
        _breakData = null;
        notifyListeners();
      }
    });
  }

  Future<void> endBreakEarly(String uid) async {
    _timer?.cancel();
    try {
      if (_breakData != null) {
        await _breakService.endBreakEarly(uid, _breakData!);
      }
      _breakData = null;
      _remainingTime = 0;
      _state = BreakState.ended;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}