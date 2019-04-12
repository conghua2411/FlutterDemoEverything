import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final List<String> _listItem;
  final ScrollController _scrollController;

  ListItem(this._listItem, this._scrollController);

  Widget _buildProductItem(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(
            index % 3 == 0 ? Icons.star : Icons.list,
            color: index % 2 == 0 ? Colors.red : Colors.blue,
          ),
          Flexible(
            child: Text(
              "name: ${_listItem[index]}",
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemBuilder: _buildProductItem,
      itemCount: _listItem.length,
    );
  }
}
