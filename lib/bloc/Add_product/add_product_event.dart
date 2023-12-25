part of 'add_product_bloc.dart';

@freezed
class AddProductEvent with _$AddProductEvent {
  const factory AddProductEvent.started() = _Started;
  // memanggil RequestModel
  const factory AddProductEvent.addProduct(ProductRequestModel request) = _Create;
}
