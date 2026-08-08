import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_assessment_task/core/error/failur.dart';
import 'package:flutter_assessment_task/core/models/paginated_response_model.dart';
import 'package:flutter_assessment_task/feature/product/domain/models/product_model.dart';
import 'package:flutter_assessment_task/feature/product/domain/models/product_details_model.dart';
import 'package:flutter_assessment_task/feature/product/domain/repositories/product_repository.dart';
import 'package:flutter_assessment_task/feature/product/domain/usecases/product_usecase.dart';

class FakeProductRepository implements ProductRepository {
  bool shouldFail = false;

  final tPaginatedResponse = PaginatedResponseModel<ProductModel>(
    data: [],
    total: 0,
    skip: 0,
    limit: 30,
  );

  final tProductDetails = ProductDetailsModel(
    id: 1,
    title: 'Test',
    description: 'Test Desc',
    price: 10,
    discountPercentage: 0,
    rating: 5,
    stock: 10,
    brand: 'Test Brand',
    category: 'Test Cat',
    thumbnail: 'test.jpg',
    images: [],
    reviews: [],
    tags: [],
    sku: '123',
    weight: 1,
    dimensions: Dimensions(width: 1, height: 1, depth: 1),
    warrantyInformation: '1 year',
    shippingInformation: 'Ships tomorrow',
    availabilityStatus: 'In Stock',
    returnPolicy: '30 days',
    minimumOrderQuantity: 1,
    meta: Meta(createdAt: '', updatedAt: '', barcode: '', qrCode: ''),
  );

  @override
  Future<Either<Failure, ProductDetailsModel>> getProductDetails(int id) async {
    if (shouldFail) {
      return Left(ServerFailure('Server Error'));
    }
    return Right(tProductDetails);
  }

  @override
  Future<Either<Failure, PaginatedResponseModel<ProductModel>>> getProducts({int skip = 0, int limit = 30}) async {
    if (shouldFail) {
      return Left(ServerFailure('Server Error'));
    }
    return Right(tPaginatedResponse);
  }

  @override
  Future<Either<Failure, PaginatedResponseModel<ProductModel>>> searchProducts(String query) async {
    if (shouldFail) {
      return Left(ServerFailure('Server Error'));
    }
    return Right(tPaginatedResponse);
  }
}

void main() {
  late ProductUsecase usecase;
  late FakeProductRepository fakeRepository;

  setUp(() {
    fakeRepository = FakeProductRepository();
    usecase = ProductUsecase(fakeRepository);
  });

  group('getProducts', () {
    test('should return PaginatedResponseModel when repository call is successful', () async {
      // Act
      final result = await usecase.getProducts(skip: 0, limit: 30);

      // Assert
      expect(result, Right(fakeRepository.tPaginatedResponse));
    });

    test('should return Failure when repository call fails', () async {
      // Arrange
      fakeRepository.shouldFail = true;

      // Act
      final result = await usecase.getProducts(skip: 0, limit: 30);

      // Assert
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'Server Error');
        },
        (_) => fail('Should have returned a Failure'),
      );
    });
  });

  group('searchProducts', () {
    test('should return PaginatedResponseModel when search is successful', () async {
      // Act
      final result = await usecase.searchProducts('phone');

      // Assert
      expect(result, Right(fakeRepository.tPaginatedResponse));
    });

    test('should return Failure when search fails', () async {
      // Arrange
      fakeRepository.shouldFail = true;

      // Act
      final result = await usecase.searchProducts('phone');

      // Assert
      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'Server Error');
        },
        (_) => fail('Should have returned a Failure'),
      );
    });
  });
}
