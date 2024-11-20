import 'package:GoDentist/app/data/network/dio_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result.freezed.dart';

@freezed
abstract class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(T data) = Success<T>;

  const factory ApiResult.failure(DioExceptions error, StackTrace stackTrace) =
      Failure<T>;
}
