import 'package:flutter/material.dart';

class MarketsScreen extends StatefulWidget {
  const MarketsScreen({super.key});

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Markets"),
    );
  }
}
