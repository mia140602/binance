import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/local_data/sharepref.dart';
import '../../../theme/palette.dart';
import '../../../widgets/custom_text.dart';

class FakeWallet extends StatefulWidget {
  const FakeWallet();

  @override
  State<FakeWallet> createState() => _FakeWalletState();
}

class _FakeWalletState extends State<FakeWallet> {
  String walletName = '';
  double? amount;
  List<Map<String, dynamic>> wallets = [];

  @override
  void initState() {
    super.initState();
    _loadWallets();
  }

  void _loadWallets() async {
    List<Map<String, dynamic>> loadedWallets = await SharePref.getAllWallets();
    setState(() {
      wallets = loadedWallets;
    });
  }

  Widget _buildWalletList() {
    final palette = Theme.of(context).extension<Palette>()!;

    if (wallets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "Không có ví",
              color: palette.appBarTitleColor,
            ),
            ElevatedButton(
              onPressed: _addWallet,
              child: CustomText(
                text: "Thêm ví",
                color: palette.appBarTitleColor,
              ),
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: wallets.length,
        itemBuilder: (context, index) {
          final wallet = wallets[index];
          return ListTile(
            title: CustomText(text: wallet["name"]),
            subtitle: CustomText(
              text: "Số tiền: ${wallet["amount"]}",
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editWallet(wallet);
                    }),
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteWallet(wallet);
                    }),
              ],
            ),
          );
        },
      );
    }
  }

  void _addWallet() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomText(text: 'Thêm ví mới', color: Colors.black),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    label: CustomText(
                      text: "Tên ví",
                      color: Colors.black,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    walletName = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    label: CustomText(
                      text: "Số tiền",
                      color: Colors.black,
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        amount = double.tryParse(value);
                      } else {
                        amount = 0;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Thêm'),
              onPressed: () async {
                if (walletName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('name trong'),
                    ),
                  );
                } else if (amount.toString().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('tien trong'),
                    ),
                  );
                } else if (walletName.isNotEmpty &&
                    amount != null &&
                    amount! > 0) {
                  await SharePref.addWallet(walletName, amount!);
                  _loadWallets();
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Vui lòng nhập tên và số tiền hợp lệ.'),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Trong _FakeWalletState class

  void _editWallet(Map<String, dynamic> wallet) {
    final palette = Theme.of(context).extension<Palette>()!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String editedWalletName = wallet["name"];
        double editedAmount = wallet["amount"];
        print(wallet["name"]);
        print(wallet["amount"]);

        TextEditingController nameController =
            TextEditingController(text: editedWalletName);
        TextEditingController amountController =
            TextEditingController(text: editedAmount.toString());

        return AlertDialog(
          backgroundColor: palette.cardColor,
          title: Text('Sửa ví'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Tên ví'),
                  controller: nameController,
                  onChanged: (value) {
                    editedWalletName = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Số tiền'),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  onChanged: (value) {
                    editedAmount = double.tryParse(value) ?? 0;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Lưu'),
              onPressed: () async {
                if (editedWalletName.isEmpty || editedAmount <= 0) {
                  print(editedWalletName);
                  print(editedAmount);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Vui lòng nhập tên và số tiền hợp lệ.'),
                    ),
                  );
                } else {
                  await SharePref.updateWallet(wallet["name"], editedAmount);
                  _loadWallets();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteWallet(Map<String, dynamic> wallet) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xóa ví'),
          content:
              Text('Bạn có chắc chắn muốn xóa ví ${wallet["name"]} không?'),
          actions: <Widget>[
            TextButton(
              child: Text('Không'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Có'),
              onPressed: () async {
                await SharePref.deleteWallet(wallet["name"]);
                _loadWallets();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;
    return Scaffold(
      backgroundColor: palette.cardColor,
      body: _buildWalletList(),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 70.0.h),
        child: FloatingActionButton(
          onPressed: _addWallet,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
