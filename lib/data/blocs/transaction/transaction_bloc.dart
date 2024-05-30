import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tikom/data/repository/auth_repository_sign_up.dart';
import 'package:tikom/data/repository/transaction_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<TransactionEvent>(onTransactionEvent);
  }

  final TransactionRepository transactionRepository = TransactionRepository();

  void onTransactionEvent(
      TransactionEvent event, Emitter<TransactionState> emit) async {
    if (event is TransactionButtonPressed) {
      emit(TransactionLoading());

      try {
        final transactionResponse = await transactionRepository.store(
          price: event.price,
          voucher: event.voucher,
          payment_method: event.payment_type,
          use_point: event.use_point,
        );
        print('masuk sini');
        print(transactionResponse);
        print(event.price);
        if (transactionResponse.status == 'success') {
          emit(TransactionSuccess());
        } else {
          print('lagi error else');
          print(transactionResponse.error);
          emit(TransactionFailure(
              error: transactionResponse.error ?? 'Unknown error'));
        }
      } catch (error) {
        print('lagi error');
        print(error);
        emit(TransactionFailure(error: error.toString()));
      }
    }
  }
}
