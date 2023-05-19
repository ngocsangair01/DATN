import 'dart:async';

import 'package:flutter/foundation.dart';

class Debouncer {
  final int seconds;
  Timer? _timer;

  Debouncer({required this.seconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: seconds), action);
  }
}

//Mặc định tìm kiếm delay sau 1s
final _debouncer = Debouncer(seconds: 1);

onTextChange(Function function, {bool isOnline = true}) {
  if (isOnline) {
    _debouncer.run(() => function());
  } else {
    function();
  }
}
