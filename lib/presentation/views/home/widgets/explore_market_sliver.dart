import 'package:flutter/material.dart';

class ExploreMarketSliver extends StatefulWidget {
  final int index;
  const ExploreMarketSliver({super.key, required this.index});

  @override
  State<ExploreMarketSliver> createState() => _ExploreMarketSliverState();
}

class _ExploreMarketSliverState extends State<ExploreMarketSliver> {
  final _childExploreMarket = [
    Container(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(
            child: Text(
          index.toString(),
        )),
        itemCount: 100,
      ),
    ),
    Container(
      height: 1000,
      child: Text("2"),
      color: Colors.blue,
    ),
    Container(
      height: 1000,
      child: Text("3"),
      color: Colors.amber,
    ),
    Container(
      height: 1000,
      child: Text("4"),
      color: Colors.deepOrange,
    ),
    Container(
      height: 1000,
      child: Text("5"),
      color: Colors.deepPurple,
    ),
    Container(
      height: 1000,
      child: Text("6"),
      color: Colors.pinkAccent,
    ),
    Container(
      height: 1000,
      child: Text("7"),
      color: Colors.white70,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return _childExploreMarket[widget.index];
  }
}
