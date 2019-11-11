import 'package:flutter/material.dart';
import 'package:tree_view/tree_view.dart';

const emptyList = [];

class Item {
  String title;
  List<Item> children;
  int level;

  Item({
    this.title = '',
    this.children,
    this.level,
  });
}

class ReorderTreeList extends StatefulWidget {
  @override
  State createState() => ReorderTreeListState();
}

class ReorderTreeListState extends State<ReorderTreeList> {
  List<String> listData = ['item1', 'item2', 'item3'];

  List<Item> treeData;

  List<Widget> listWidgetTree = [];

  List<Item> listTreeData = [];

  @override
  void initState() {
    super.initState();

    treeData = [
      Item(title: 'father1', level: 0, children: [
        Item(title: 'child1', level: 1),
        Item(title: 'child2', level: 1),
        Item(title: 'child3', level: 1),
      ]),
      Item(title: 'father2', level: 0, children: [
        Item(title: 'child4', level: 1),
        Item(title: 'child5', level: 1),
        Item(title: 'child6', level: 1, children: [
          Item(title: 'child16', level: 2),
          Item(title: 'child17', level: 2),
          Item(title: 'child18', level: 2),
          Item(title: 'child19', level: 2),
        ]),
        Item(title: 'child7', level: 1),
        Item(title: 'child8', level: 1),
        Item(title: 'child9', level: 1),
        Item(title: 'child10', level: 1),
      ]),
      Item(title: 'father3', level: 0, children: [
        Item(title: 'child11', level: 1),
        Item(title: 'child12', level: 1),
        Item(title: 'child13', level: 1),
        Item(title: 'child14', level: 1),
        Item(title: 'child15', level: 1),
      ]),
    ];

    listTreeData = convertTreeToList(treeData);

    print('list : ${listTreeData.length}');

    listWidgetTree = convertTreeToListWidget(treeData);

    print('listWidget : ${listWidgetTree.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ReorderTreeList'),
      ),
      body: Center(
//        child: _buildTreeAndReoderListView(treeData),
//        child: SingleChildScrollView(
//          scrollDirection: Axis.vertical,
//          child: _buildListItemTreeView(treeData),
//        ),
//        child: buildListFromTree(treeData),
//        child: buildListFromTree2(),
        child: buildListFromTree3(),
//        child: _buildReoderableListView2(),
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
        print(
            '_buildReoderableListView2: oldIndex: $oldIndex ---- newIndex: $newIndex');
        if (newIndex > listData.length - 1) {
          newIndex = listData.length - 1;
        }

        if (oldIndex != newIndex && newIndex < listData.length) {
          setState(() {
            String item = listData[oldIndex];

            listData.removeAt(oldIndex);

            listData.insert(newIndex, item);
          });
        }
      },
    );
  }

  _buildTreeAndReoderListView(List<Item> data) {
    print('asdasd asdas das dasdasd ${data.length}');
    return ReorderableListView(
      children: data.map(
        (item) {
          return _buildTreeItem(item);
        },
      ).toList(),
      onReorder: (oldIndex, newIndex) {},
    );
  }

  Widget _buildTreeItem(Item treeData) {
    return Container(
      color: Colors.transparent,
      key: ValueKey(treeData.title),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.amber, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(treeData.title),
              ),
            ),
            Container(
              height: treeData.children != null
                  ? treeData.children.length * 66.0
                  : 0,
              child: treeData.children != null
                  ? Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: _buildTreeAndReoderListView(treeData.children),
                        ),
                      ],
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  /// build tree view
  Widget _buildItemTreeView(Item item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.amber,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(item.title),
            ),
          ),
          item.children != null
              ? Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(child: _buildListItemTreeView(item.children)),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildListItemTreeView(List<Item> listItem) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: listItem.map((item) {
        return _buildItemTreeView(item);
      }).toList(),
    );
  }

  /// 1 list
//  Widget _build1List(List<Item> tree) {
//    List<Widget> listItem = _getListItemFromTree(tree);
//  }

//  List<Widget> _getListItemFromTree(List<Item> tree, {int level = 0}) {
//    return tree.map((item) {
//      return
//    }).toList();
//  }

  Widget _getItemFromTree(Item item, {int level = 0}) {
    return Row(
      children: <Widget>[
        SizedBox(width: 20.0 * level),
        Expanded(
          child: Container(
            child: Text(item.title),
          ),
        ),
      ],
    );
  }

  List<Item> convertTreeToList(List<Item> tree) {
    List<Item> listReturn = [];
    if (tree == null || tree.length == 0) {
      return [];
    }

    tree.forEach((item) {
      listReturn.add(item);
      listReturn.addAll(convertTreeToList(item.children));
    });

    return listReturn;
  }

  List<Widget> convertTreeToListWidget(List<Item> tree, {int level = 0}) {
    List<Widget> list = [];

    if (tree == null || tree.length == 0) {
      return [];
    }

    tree.forEach((item) {
      list.add(Container(
        height: 50,
        key: ValueKey(item.title),
        child: Row(
          children: [
            SizedBox(
              width: 20.0 * level,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.amber,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(item.title),
                ),
              ),
            ),
          ],
        ),
      ));
      list.addAll(convertTreeToListWidget(item.children, level: level + 1));
    });

    return list;
  }

  Widget buildListFromTree(List<Item> tree) {
    List<Widget> listConvert = convertTreeToListWidget(tree);

    return ReorderableListView(
      children: listConvert,
      onReorder: (oldIndex, newIndex) {
        print(
            'buildListFromTree: oldIndex - $oldIndex --- newIndex - $newIndex');
        if (newIndex > listData.length - 1) {
          newIndex = listData.length - 1;
        }

        if (oldIndex != newIndex && newIndex < listData.length) {
          setState(() {
            String item = listData[oldIndex];

            listData.removeAt(oldIndex);

            listData.insert(newIndex, item);
          });
        }
      },
    );
  }

  Widget buildListFromTree2() {
    return ReorderableListView(
      children: listWidgetTree,
      onReorder: (oldIndex, newIndex) {
        print(
            'buildListFromTree2: oldIndex - $oldIndex --- newIndex - $newIndex');
        if (newIndex > listWidgetTree.length - 1) {
          newIndex = listWidgetTree.length - 1;
        }

        if (oldIndex != newIndex && newIndex < listWidgetTree.length) {
          setState(() {
            Widget item = listWidgetTree[oldIndex];

            listWidgetTree.removeAt(oldIndex);

            listWidgetTree.insert(newIndex, item);

            print('buildListFromTree2: finish');
          });
        }
      },
    );
  }

  Widget buildListFromTree3() {
    return ReorderableListView(
      children: listTreeData.map((item) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          key: ValueKey(item.title),
          child: Container(
            height: 50,
            child: Row(
              children: [
                SizedBox(
                  width: 50.0 * item.level,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.amber,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(item.title),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
      onReorder: (oldIndex, newIndex) {
        print(
            'buildListFromTree2: oldIndex - $oldIndex --- newIndex - $newIndex');

        if (oldIndex != newIndex && newIndex <= listTreeData.length) {
          setState(() {
            Item item = listTreeData[oldIndex];

            listTreeData.removeAt(oldIndex);

            if (newIndex > oldIndex) {
              newIndex--;
            }

            listTreeData.insert(newIndex, item);

            print('buildListFromTree2: finish');
          });
        }
      },
    );
  }
}
