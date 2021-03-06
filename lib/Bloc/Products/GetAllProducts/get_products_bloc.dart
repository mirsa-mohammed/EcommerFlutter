import 'package:bloc/bloc.dart';
import 'package:ecommerceapi/Api/Product/productApi.dart';
import 'package:ecommerceapi/Api/Product/productModel.dart';



part 'get_products_event.dart';
part 'get_products_state.dart';

class GetProductsBloc extends Bloc<GetProductsEvent, GetProductsState> {
  late List<ProductModel> productModel;
  ProductApi productApi;

  GetProductsBloc(this.productApi) : super(GetProductsInitial()) {
    on<GetProducts>(
      (event, emit) async {
        emit(ProductsLoading());
        try {
          productModel = await productApi.getProduct();
          emit(ProductsLoaded());
        } catch (e) {
          print('Bloc============================$e');
          emit(ProductsError());
        }
      },
    );
  }
}
