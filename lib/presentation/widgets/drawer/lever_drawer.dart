import 'package:flutter/material.dart';

import '../../theme/palette.dart';

class LeverDrawerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<Palette>()!;

    return Container(
      decoration: BoxDecoration(color: palette.selectedTabChipColor),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        children: [
          // Add your drawer items here
          ListTile(
            title: Text('Option 1'),
            // onTap: () => Navigator.pop(context), // Close drawer on tap
          ),
          ListTile(
            title: Text('Option 2'),
            // onTap: () => Navigator.pop(context), // Close drawer on tap
          ),
          // ... more options
        ],
      ),
    );
  }
}
