import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final Duration duration;
  Timer? _timer;
  Debouncer({
    this.duration = const Duration(milliseconds: 200),
  });
  call(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(duration, callback);
  }

  delay(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 1), callback);
  }

  // bool callWithValue(VoidCallback callback, bool notification) {
  //   _timer?.cancel();
  //   _timer = Timer(duration, callback);
  //   return notification;
  // }

  dispose() {
    _timer?.cancel();
  }
}
