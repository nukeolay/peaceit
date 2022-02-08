import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class DisableMultitouch extends OneSequenceGestureRecognizer {
  int _p = 0;
  @override
  void addPointer(PointerDownEvent event) {
    startTrackingPointer(event.pointer);
    if (_p == 0) {
      resolve(GestureDisposition.rejected);
      _p = event.pointer;
    } else {
      resolve(GestureDisposition.accepted);
    }
  }

  @override
  String get debugDescription => 'only one pointer recognizer';

  @override
  void didStopTrackingLastPointer(int pointer) {}

  @override
  void handleEvent(PointerEvent event) {
    if (!event.down && event.pointer == _p) {
      _p = 0;
    }
  }
}

class DisableMultitouchWidget extends StatelessWidget {
  final Widget child;
  const DisableMultitouchWidget({
    required this.child,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        DisableMultitouch:
            GestureRecognizerFactoryWithHandlers<DisableMultitouch>(
          () => DisableMultitouch(),
          (DisableMultitouch instance) {},
        ),
      },
      child: child,
    );
  }
}
