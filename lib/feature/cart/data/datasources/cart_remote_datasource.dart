import 'package:dio/dio.dart';
import 'package:flutter_assessment_task/core/constant/api_constant.dart';
import 'package:flutter_assessment_task/core/error/exception.dart';
import 'package:flutter_assessment_task/feature/cart/domain/models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> getCart(int id);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final Dio dio;

  CartRemoteDataSourceImpl({required this.dio});

  @override
  Future<CartModel> getCart(int id) async {
    try {
      final response = await dio.get(ApiConstant.cartDetail(id));
      if (response.statusCode == 200) {
        return CartModel.fromJson(response.data);
      }
      throw ServerException();
    } on DioException catch (e) {
      if (e.error is NetworkException) {
        throw e.error as NetworkException;
      }
      throw ServerException(e.message ?? 'Unknown Error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
