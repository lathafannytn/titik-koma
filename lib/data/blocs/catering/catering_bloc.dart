import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tikom/data/models/transaction_full_service.dart';

import 'package:tikom/data/repository/event_data_repository.dart';
import 'package:tikom/data/repository/full_service_cafe_repository.dart';
import 'package:tikom/data/repository/full_service_repository.dart';

part 'catering_event.dart';
part 'catering_state.dart';

class CateringBloc extends Bloc<CateringBlocEvent, CateringBlocState> {
  CateringBloc() : super(CateringBlocInitial()) {
    on<CateringBlocEvent>(onCateringEvent);
  }

  final FullServiceRepository _fullServiceRepository = FullServiceRepository();
  final FullServiceCafeRepository _fullServiceCafeRepository =
      FullServiceCafeRepository();

  void onCateringEvent(
      CateringBlocEvent event, Emitter<CateringBlocState> emit) async {
    if (event is CateringBlocButtonPressed) {
      print('masuk');
      emit(CateringBlocLoading());
      try {
        print(event);
        TransactionFullServiceStoreResponse cateringResponse;
        if (event.product_list != null) {
          cateringResponse = await _fullServiceCafeRepository.store(
            price: int.parse(event.price),
            voucher: event.voucher,
            custom_cup_name: event.custom_cup_name,
            payment_method: event.payment_type,
            use_point: event.use_point,
            base_delivery: event.base_delivery,
            delivery_address: event.delivery_address,
            delivery_price: event.delivery_price,
            custom_cup_note: event.custom_cup_note,
            add_on: event.add_on,
            service_date: event.service_date,
            service: event.service,
            product_list: event.product_list!,
            package: event.package!,
          );
        } else {
          cateringResponse = await _fullServiceRepository.store(
              price: int.parse(event.price),
              voucher: event.voucher,
              custom_cup_name: event.custom_cup_name,
              products: event.products!,
              payment_method: event.payment_type,
              use_point: event.use_point,
              base_delivery: event.base_delivery,
              delivery_address: event.delivery_address,
              delivery_price: event.delivery_price,
              custom_cup_note: event.custom_cup_note,
              add_on: event.add_on,
              service_date: event.service_date,
              service: event.service);
        }
        // print('masuk');
        print(cateringResponse.message);
        print('disini');
        if (cateringResponse.status == 'success') {
          emit(CateringBlocSuccess(message: cateringResponse.message));
        } else {
          emit(CateringBlocFailure(
              message: cateringResponse.message,
              error: 'Not Server' ?? 'Unknown error'));
        }
      } catch (error) {
        print(error);
        emit(CateringBlocFailure(
            message: 'Server Error ', error: error.toString()));
      }
    }
  }
}
