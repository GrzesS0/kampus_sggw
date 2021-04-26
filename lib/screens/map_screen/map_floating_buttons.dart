import 'package:flutter/material.dart';
import 'package:kampus_sggw/logic/search_history.dart';
import 'search_bar.dart';

class MapFloatingButtons extends StatelessWidget {
  final SearchHistory searchHistory;

  const MapFloatingButtons({Key key, this.searchHistory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          child: const Icon(Icons.map),
          backgroundColor: Colors.lightGreen,
          onPressed: () {},
        ),
        Padding(
          padding: EdgeInsets.all(5),
        ),
        FloatingActionButton(
          child: const Icon(Icons.search),
          backgroundColor: Colors.green,
          onPressed: () => _onSearchButtonPressed(context),
        ),
      ],
    );
  }

  void _onSearchButtonPressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: SearchBar(
          searchHistory: searchHistory,
        ),
      ),
    );
  }
}
