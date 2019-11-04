import 'package:flutter/material.dart';
import 'package:tree_view/tree_view.dart';

class ReorderTreeList extends StatefulWidget {
  @override
  State createState() => ReorderTreeListState();
}

class ReorderTreeListState extends State<ReorderTreeList> {
  List<String> listData = ['item1', 'item2', 'item3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ReorderTreeList'),
      ),
      body: Center(
        child: _buildReoderableListView2(),
      ),
    );
  }

  _buildTreeViewDemo() {
    return TreeView(
      parentList: [
        Parent(
          parent: Container(
            color: Colors.red,
            child: Text(
              'Desktop',
            ),
          ),
          childList: ChildList(
            children: <Widget>[
              Parent(
                parent: Text('documents'),
                childList: ChildList(
                  children: <Widget>[
                    Text('Resume.docx'),
                    Text('Billing-Info.docx'),
                  ],
                ),
              ),
              Text('MeetingReport.xls'),
              Text('MeetingReport.pdf'),
              Text('Demo.zip'),
            ],
          ),
        ),
      ],
    );
  }

  _buildReorderableListView() {
    return ReorderableListView(
      children: [
        Container(
          key: ValueKey(1),
          width: double.infinity,
          height: 100,
          child: Center(
            child: Text(
              'alo 1',
            ),
          ),
        ),
        Container(
          key: ValueKey(2),
          width: double.infinity,
          height: 100,
          child: Center(
            child: Text(
              'alo 2',
            ),
          ),
        ),
        Container(
          key: ValueKey(3),
          width: double.infinity,
          height: 100,
          child: Center(
            child: Text(
              'alo 3',
            ),
          ),
        ),
      ],
      onReorder: (oldIndex, newIndex) {
        print('oldIndex: $oldIndex ---- newIndex: $newIndex');
      },
    );
  }

  _buildReoderableListView2() {
    return ReorderableListView(
      children: listData.map((data) {
        return Container(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 2,
              color: Colors.white,
            ),
            color: Colors.amber,
          ),
          key: ValueKey(data),
          child: Text('$data'),
        );
      }).toList(),
      onReorder: (oldIndex, newIndex) {
        if (oldIndex != newIndex && newIndex < listData.length) {
          print(
              '_buildReoderableListView2: oldIndex: $oldIndex ---- newIndex: $newIndex');

          setState(() {
            String item = listData[oldIndex];

            listData.removeAt(oldIndex);

            listData.insert(newIndex, item);
          });
        }
      },
    );
  }
}
