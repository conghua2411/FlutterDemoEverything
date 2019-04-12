import 'package:flutter/material.dart';
import 'package:flutter_app/shoppingCart/bloc/ShoppingBloc.dart';
import 'package:flutter_app/shoppingCart/model/cart.dart';
import 'package:flutter_app/shoppingCart/model/item.dart';
import 'package:flutter_app/shoppingCart/screen/totalCart.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppBar extends StatelessWidget {

  const MyAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      title: Text(
        'cart list',
        style: Theme.of(context).textTheme.display4.copyWith(fontSize: 30.0),
      ),
      floating: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            BlocProvider.of<ShoppingBloc>(context).dispatch(FinishShopping());
          },
        ),
      ],
    );
  }
}
//() => shoppingBloc.dispatch(FinishShopping())
class MyCartList extends StatefulWidget {
  MyCartList({Key key}) : super(key: key);

  @override
  _MyCartListState createState() => _MyCartListState();
}

class _MyCartListState extends State<MyCartList> {
  final _shoppingBloc = ShoppingBloc();

  final cart = CartModel();

  @override
  void dispose() {
    _shoppingBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CartModel>(
        model: cart,
        child: BlocProviderTree(
          blocProviders: [
            BlocProvider<ShoppingBloc>(bloc: _shoppingBloc),
          ],
          child: BlocBuilder(
            bloc: _shoppingBloc,
            builder: (BuildContext context, ShoppingState state) {
              if (state is ShoppingListState) {
                return Scaffold(
                  body: CustomScrollView(
                    slivers: <Widget>[
                      MyAppBar(),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 12,
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                                (context, index) => MyListItem(index)),
                      )
                    ],
                  ),
                );
              } else if (state is CartState) {
                return TotalCart();
              }
            },
          ),
        ));
  }
}

class MyListItem extends StatelessWidget {
  final int index;

  final Item item;

  MyListItem(this.index, {Key key})
      : item = Item(index),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Colors.primaries[index % Colors.primaries.length],
              ),
            ),
            SizedBox(
              width: 50,
            ),
            Expanded(
              child: Text(
                item.name,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            SizedBox(
              width: 24,
            ),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(
      builder: (context, child, cart) => FlatButton(
            onPressed: cart.items.contains(item) ? null : () => cart.add(item),
            splashColor: Colors.yellow,
            child: cart.items.contains(item) ? Icon(Icons.check) : Text('ADD'),
          ),
    );
  }
}
