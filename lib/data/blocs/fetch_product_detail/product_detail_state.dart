


import 'package:tikom/data/models/product.dart';

class ProductDetailDataState {}

class ProductDetailDataInitial extends ProductDetailDataState {}

class ProductDetailDataLoading extends ProductDetailDataState {}

class ProductDetailDataLoaded extends ProductDetailDataState {
  final ProductDetail productDetail;
  ProductDetailDataLoaded(this.productDetail);
}

class ProductDetailDataError extends ProductDetailDataState {
  final String message;
  ProductDetailDataError(this.message);
}