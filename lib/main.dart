import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:binance_clone/app.dart';
import 'package:binance_clone/utils/logger.dart';

void main() {
  LoggerConfig.disableLogs();
  runApp(const ProviderScope(child: SissyphusApp()));
}


