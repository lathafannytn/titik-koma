import 'package:equatable/equatable.dart';
import 'package:tikom/data/models/bundle.dart';


abstract class BundleState extends Equatable {
  const BundleState();

  @override
  List<Object> get props => [];
}

class BundleInitial extends BundleState {}

class BundleLoading extends BundleState {}

class BundleSuccess extends BundleState {
  BundleSuccess(this.bundle);

  final List<Bundle> bundle;

  @override
  List<Object> get props => [bundle];
}


class BundleFailure extends BundleState {
  final String message;

  BundleFailure(this.message);

  @override
  List<Object> get props => [message];
}
