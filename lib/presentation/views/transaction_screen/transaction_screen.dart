import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_clone/utils/binance_testnest.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/local_data/sharepref.dart';
import '../../theme/palette.dart';
import '../../widgets/wallet_tabbar.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<String> wallets = [];
  int selectedWalletIndex = 0;
  String selectedPosition = "Long";
  final List<String> positions = ["Long", "Short"];
  String selectedSymbol = "BTCUSDT";
  final TextEditingController entryPriceController = TextEditingController();
  final TextEditingController leverageController = TextEditingController();
  final TextEditingController marginController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadWallets();
  }

  void loadWallets() async {
    var walletData = await SharePref.getAllWallets();
    setState(() {
      wallets = walletData.map((wallet) => wallet['name'] as String).toList();
      if (wallets.isNotEmpty) {
        selectedWalletIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: palette.cardColor,
        appBar: AppBar(
          title: CustomText(text: "Create Position"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Create Position"),
              Tab(text: "Create Order"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildPositionCreation(),
            Center(
              child: CustomText(text: "Create Order"),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPositionCreation() {
    final palette = Theme.of(context).extension<Palette>()!;
    BinanceTestnetAPI binanceAPI = BinanceTestnetAPI();

    return SingleChildScrollView(
      child: Column(
        children: [
          WalletTabBar(
            tabs: wallets,
            index: selectedWalletIndex,
            onChanged: (int newIndex) {
              setState(() {
                selectedWalletIndex = newIndex;
              });
            },
            selectedTabBorderColor: palette.mainYellowColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          DropdownButton<String>(
            value: selectedPosition,
            dropdownColor: palette.selectedTabChipColor,
            items: positions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedPosition = newValue!;
              });
            },
          ),
          DropdownButton<String>(
            value: selectedSymbol,
            dropdownColor: palette.selectedTabChipColor,
            items: <String>['BTCUSDT']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedSymbol = newValue!;
              });
            },
          ),
          inputForm(
            controller: entryPriceController,
            label: "Entry Price",
          ),
          inputForm(
            controller: leverageController,
            label: "Leverage",
          ),
          inputForm(
            controller: marginController,
            label: "User Margin",
          ),
          ElevatedButton(
            onPressed: () {
              // Thêm logic để tạo vị thế tại đây
              print(
                  "Creating position with: Wallet ${wallets[selectedWalletIndex]}, Position $selectedPosition, Symbol $selectedSymbol");
              double quantity = double.tryParse(entryPriceController.text) ?? 0;
              double currentPrice = double.tryParse(marginController.text) ?? 0;
              String walletName = wallets[selectedWalletIndex];
              String side = selectedPosition == "Long" ? "BUY" : "SELL";

              binanceAPI
                  .placeOrderWithWalletBalance(
                      walletName, selectedSymbol, side, quantity, currentPrice)
                  .then((response) {
                print(response); // In phản hồi ra console
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text(response)) // Hiển thị phản hồi trong SnackBar
                    );
              }).catchError((error) {
                print("Error when placing order: $error");
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Error when placing order: $error")));
              });
            },
            child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color(0xfff0b90b),
                    borderRadius: BorderRadius.circular(10)),
                child: CustomText(text: "Create Position")),
          ),
        ],
      ),
    );
  }
}

class inputForm extends StatelessWidget {
  const inputForm({super.key, required this.controller, required this.label});

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: palette.selectedTimeChipColor,
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
