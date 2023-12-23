import 'package:bloc/bloc.dart';
import 'package:flutter_seller_app/data/datasource/product_remote_datasource.dart';
import 'package:flutter_seller_app/data/model/products_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const _Initial()) {
    on<_GetProduct>((event, emit) async {
      emit(const _Loading());
      final response = await ProductRemoteDatasource().getPorducts();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
