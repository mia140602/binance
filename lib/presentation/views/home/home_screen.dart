import 'package:binance_clone/presentation/theme/palette.dart';
import 'package:binance_clone/presentation/views/home/widgets/home_container.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Scaffold(
      body: const HomeContainer(),
      backgroundColor: palette.cardColor,
    );
  }
}
