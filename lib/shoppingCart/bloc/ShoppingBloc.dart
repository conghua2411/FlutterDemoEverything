import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class ShoppingEvent extends Equatable {
}

class FinishShopping extends ShoppingEvent {}

class StartShopping extends ShoppingEvent {}

abstract class ShoppingState extends Equatable {}

class ShoppingListState extends ShoppingState {}

class CartState extends ShoppingState {}

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {

  @override
  ShoppingState get initialState => ShoppingListState();

  @override
  Stream<ShoppingState> mapEventToState(ShoppingEvent event) async* {
    if (event is FinishShopping) {
      yield CartState();
    } else if (event is StartShopping) {
      yield ShoppingListState();
    }
  }
}