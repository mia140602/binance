import 'package:binance_clone/presentation/views/wallets/tabbar_option/fakeWallet.dart';
import 'package:binance_clone/presentation/widgets/custom_appbar.dart';
import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      // appBar: MyAppBar(),
      appBar: AppBar(
        title: CustomText(text: "Danh sách ví"),
      ),
      body: FakeWallet(),
    );
  }
}
