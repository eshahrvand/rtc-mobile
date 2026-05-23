import 'package:flutter/material.dart';
import 'package:rtc_mobile/ui/presenters/rtc_app/rtc_app.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  runApp(const RtcApp());
}
