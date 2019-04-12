import 'package:flutter/material.dart';
import 'package:flutter_app/shoppingCart/bloc/ShoppingBloc.dart';
import 'package:flutter_app/shoppingCart/model/cart.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalCart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(
      builder: (context, child, cart) =>
          WillPopScope(
            onWillPop: () => _backShopping(context, cart),
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white,),
                    onPressed: () {
                      BlocProvider.of<ShoppingBloc>(context).dispatch(
                          StartShopping());
                      cart.clear();
                    }),
                title: Text(
                  'Cart',
                  style: Theme
                      .of(context)
                      .textTheme
                      .display4
                      .copyWith(fontSize: 30.0),
                ),
              ),
              body: Container(
                color: Colors.yellow,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: _CartList(),
                      ),
                    ),
                    Container(
                      height: 4,
                      color: Colors.black,
                    ),
                    _CartTotal()
                  ],
                ),
              ),
            ),
          ),
    );
  }

  Future<void> _backShopping(BuildContext context, CartModel cart) async {
    BlocProvider.of<ShoppingBloc>(context).dispatch(StartShopping());
    cart.clear();
  }
}

class _CartList extends StatelessWidget {
  const _CartList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CartModel>(
      builder: (context, child, cart) => ListView(
            children: cart.items
                .map((item) => Text(
                      '- ${item.name}',
                      style: Theme.of(context).textTheme.title,
                    ))
                .toList(),
          ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScopedModelDescendant<CartModel>(
              builder: (context, child, cart) => Text(
                    '\$${cart.totalPrice}',
                    style: Theme.of(context)
                        .textTheme
                        .display4
                        .copyWith(fontSize: 48),
                  ),
            ),
            SizedBox(
              width: 24,
            ),
            FlatButton(
              onPressed: () {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Buying not support yet.')));
              },
              color: Colors.white,
              child: Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}
