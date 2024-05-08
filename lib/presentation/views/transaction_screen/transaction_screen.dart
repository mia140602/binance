import 'package:binance_clone/presentation/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_clone/utils/binance_testnest.dart';
import 'package:gap/gap.dart';

import '../../../data/local_data/sharepref.dart';
import '../../theme/palette.dart';
import '../../widgets/position_card.dart';
import '../../widgets/wallet_tabbar.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  List<Map<String, dynamic>> positionsList = [];
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
    loadPositions();
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController!.indexIsChanging) {
      entryPriceController.clear();
      leverageController.clear();
      marginController.clear();
    }
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

  void loadPositions() async {
    var positions = await SharePref.getAllPositions();
    setState(() {
      positionsList = positions;
    });
  }

  void createPosition() async {
    double entryPrice = double.tryParse(entryPriceController.text) ?? 0;
    double leverage = double.tryParse(leverageController.text) ?? 0;
    double margin = double.tryParse(marginController.text) ?? 0;
    String symbol = selectedSymbol;
    String type = selectedPosition;

    await SharePref.addPosition(symbol, type, entryPrice, leverage, margin);
    // await SharePref.addPosition(symbol, entryPrice, leverage, margin);
    loadPositions();

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Position created successfully!")));
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;

    return Scaffold(
      backgroundColor: palette.cardColor,
      appBar: AppBar(
        title: CustomText(text: "Create Position"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Create Position"),
            Tab(text: "Create Order"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildPositionCreation(),
          buildOrderCreation(),
        ],
      ),
    );
  }

  Widget buildPositionCreation() {
    final palette = Theme.of(context).extension<Palette>()!;

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
            label: "Margin",
          ),
          ElevatedButton(
            onPressed: () async {
              createPosition();
            },
            child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color(0xfff0b90b),
                    borderRadius: BorderRadius.circular(10)),
                child: CustomText(text: "Create Position")),
          ),
          buildPositionList(),
          Gap(50),
        ],
      ),
    );
  }

  Widget buildOrderCreation() {
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
            onPressed: () async {
              double entryPrice =
                  double.tryParse(entryPriceController.text) ?? 0;
              double leverage = double.tryParse(leverageController.text) ?? 0;
              double userMargin = double.tryParse(marginController.text) ?? 0;
              String walletName = wallets[selectedWalletIndex];
              String side = selectedPosition == "Long" ? "BUY" : "SELL";

              try {
                String response = await binanceAPI.placeOrderWithWalletBalance(
                    walletName, selectedSymbol, side, entryPrice, userMargin);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(response),
                ));
                print(response);
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Error when placing order: $error"),
                ));
                print("Error when placing order: $error");
              }
            },
            child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color(0xfff0b90b),
                    borderRadius: BorderRadius.circular(10)),
                child: CustomText(text: "Create Order")),
          ),
        ],
      ),
    );
  }

  Widget buildPositionList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: positionsList.length,
      itemBuilder: (context, index) {
        var position = positionsList[index];
        return PositionCard(position: position);
      },
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