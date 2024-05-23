import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tikom/data/repository/auth_repository_email.dart';
import 'package:tikom/data/repository/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>(onOrderEvent);
  }

  final OrderRepository orderRepository = OrderRepository();

  void onOrderEvent(OrderEvent event, Emitter<OrderState> emit) async {
    if (event is OrderButtonPressed) {
      emit(OrderLoading());

      try {
        final OrderResponse = await orderRepository.authenticate(
          products: event.products,
          selected: event.selected,
          add_on: event.add_on,
          total: event.total,
        );
        if (OrderResponse.status == 'success') {
          emit(OrderSuccess(message: OrderResponse.message));
        } else {
          emit(OrderFailure(
              message: OrderResponse.message,
              error: 'Not Server' ?? 'Unknown error'));
        }
      } catch (error) {
        print(error);
        emit(OrderFailure(message: 'Server Error ', error: error.toString()));
      }
    }
  }
}
