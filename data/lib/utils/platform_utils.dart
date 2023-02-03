import 'package:flutter/foundation.dart';

bool isMobile() =>
    defaultTargetPlatform == TargetPlatform.android ||
    defaultTargetPlatform == TargetPlatform.iOS;
