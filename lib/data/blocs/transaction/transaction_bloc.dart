// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tikom/data/models/transaction.dart';
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
          service_date: event.service_date,
          is_delivery: event.is_delivery,
          base_delivery: event.base_delivery, 
          delivery_address: event.delivery_address, 
          delivery_price:event.delivery_price,
    
        );
        print('masuk sini');
        print(transactionResponse);
        print(event.price);
        if (transactionResponse.status == 'success') {
          emit(TransactionSuccess( message: transactionResponse.message));
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

  Future<void> dataFilter(String filter) async {
    emit(TransactionLoading());
    print('From Cubit');
    try {
      final response = await transactionRepository.dataStatus(filter: filter);
      print('From Cubit');
      print(response);
      if (response != null && response.data != null) {
        print('hm');
        print(response.data!);
        emit(TransactionSuccessData(response.data!));
      } else {
        emit(TransactionFailure(error: response.message));
      }
    } catch (error) {
      print(error.toString());
      emit(TransactionFailure(
        error: error.toString(),
      ));
    }
  }



  Future<void> data() async {
    emit(TransactionLoading());
    print('From Cubit');
    try {
      final response = await transactionRepository.data();
      print('From Cubit');
      print(response);
      if (response != null && response.data != null) {
        print('hm');
        print(response.data!);
        emit(TransactionSuccessData(response.data!));
      } else {
        emit(TransactionFailure(error: response.message));
      }
    } catch (error) {
      print(error.toString());
      emit(TransactionFailure(
        error: error.toString(),
      ));
    }
  }

  Future<void> dataDetail(String uuid) async {
    emit(TransactionLoading());
    print('From Cubit');
    try {
      final response = await transactionRepository.dataDetail(uuid: uuid);
      print('From Cubit');
      print(response);
      if (response != null && response.data != null) {
        print('hm');
        print(response.data!);
        emit(TransactionSuccessData(response.data!));
      } else {
        emit(TransactionFailure(error: response.message));
      }
    } catch (error) {
      print(error.toString());
      emit(TransactionFailure(
        error: error.toString(),
      ));
    }
  }



}
