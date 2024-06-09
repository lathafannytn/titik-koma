import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tikom/data/blocs/fetch_add_on_catering/add_on_catering_state.dart';
import 'package:tikom/data/repository/full_service_repository.dart';

class AddOnCateringDataCubit extends Cubit<AddOnCateringDataState> {
  AddOnCateringDataCubit() : super(AddOnCateringDataInitial());

  final FullServiceRepository _fullServiceRepository = FullServiceRepository();

  Future<void> loadAddOnCatering() async {
    emit(AddOnCateringDataLoading());
    print('hallo');
    try {
      print('hallo');
      final response = await _fullServiceRepository.showAddOnCatering();
      print(response.data);
      emit(AddOnCateringDataSuccess(response.data));
    } catch (error) {
      emit(AddOnCateringDataFailure(error.toString()));
    }
  }
}
