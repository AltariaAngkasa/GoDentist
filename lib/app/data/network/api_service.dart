import 'dart:io';
import 'package:GoDentist/app/common/sources/api.dart';
import 'package:GoDentist/app/data/models/articles/article_response.dart';
import 'package:GoDentist/app/data/models/auth/forgot_password_response.dart';
import 'package:GoDentist/app/data/models/auth/login_response.dart';
import 'package:GoDentist/app/data/models/auth/register_response.dart';
import 'package:GoDentist/app/data/models/auth/reset_password_response.dart';
import 'package:GoDentist/app/data/models/auth/verify_email_response.dart';
import 'package:GoDentist/app/data/models/auth/verify_otp_response.dart';
import 'package:GoDentist/app/data/models/clinic/clinic_response.dart';
import 'package:GoDentist/app/data/models/clinic/detail_clinic_response.dart';
import 'package:GoDentist/app/data/models/detection/detection_teet_response.dart';
import 'package:GoDentist/app/data/models/doctor/doctor_response.dart';
import 'package:GoDentist/app/data/models/doctor/search_doctor_response.dart';
import 'package:GoDentist/app/data/models/history/get_consultation_history_response.dart';
import 'package:GoDentist/app/data/models/history/history_booking_clinic_response.dart';
import 'package:GoDentist/app/data/models/history/history_consultation_response.dart';
import 'package:GoDentist/app/data/models/payments/check_booking_doctor_payment_response.dart';
import 'package:GoDentist/app/data/models/payments/check_payment_consultation_response.dart';
import 'package:GoDentist/app/data/models/payments/payment_booking_doctor_response.dart';
import 'package:GoDentist/app/data/models/payments/payment_consultation_response.dart';
import 'package:GoDentist/app/data/models/profile/change_password_response.dart';
import 'package:GoDentist/app/data/models/profile/delete_profile_response.dart';
import 'package:GoDentist/app/data/models/profile/profile_response.dart';
import 'package:GoDentist/app/data/models/profile/update_profile_response.dart';
import 'package:GoDentist/app/data/models/promo/promo_response.dart';
import 'package:GoDentist/app/data/network/api_result.dart';
import 'package:GoDentist/app/data/network/dio_client.dart';
import 'package:GoDentist/app/data/network/dio_exception.dart';
import 'package:GoDentist/app/data/sessions/session.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';

class ApiService {
  final dioClient = DioClient(Dio());
  final secureStorage = const FlutterSecureStorage();

  Future<ApiResult<LoginResponse>> login(
    String email,
    String passaword,
  ) async {
    String url = API.baseURL;
    try {
      String baseUrl = "$url/patients/login/email";
      final response = await dioClient.post(
        baseUrl,
        data: {
          'email': email,
          'password': passaword,
        },
      );
      final result = LoginResponse.fromJson(response);
      //
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<RegisterResponse>> register(
    String name,
    String? gender,
    String email,
    String passaword,
    String noHp,
  ) async {
    String url = API.baseURL;
    try {
      String baseUrl = "$url/patients";
      final response = await dioClient.post(
        baseUrl,
        data: {
          'name': name,
          'gender': gender,
          'email': email,
          'password': passaword,
          'phoneNumber': noHp,
        },
      );
      final result = RegisterResponse.fromJson(response);
      //
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<VerifyEmailResponse>> verifyEmail(
    String email,
    String otp,
  ) async {
    String url = API.baseURL;
    try {
      String baseUrl = "$url/patients/email/verify";
      final response = await dioClient.post(
        baseUrl,
        data: {
          'email': email,
          'otp': otp,
        },
      );
      final result = VerifyEmailResponse.fromJson(response);
      //
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<ForgotPasswordResponse>> forgotPassword(
    String email,
  ) async {
    String url = API.baseURL;
    try {
      String baseUrl = "$url/patients/password/forgot";
      final response = await dioClient.post(
        baseUrl,
        data: {
          'email': email,
        },
      );
      final result = ForgotPasswordResponse.fromJson(response);
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<VerifyOTPResponse>> verifyOTP(
    String email,
    String otp,
  ) async {
    String url = API.baseURL;
    try {
      String baseUrl = "$url/patients/password/verify";
      final response = await dioClient.post(
        baseUrl,
        data: {
          'email': email,
          'otp': otp,
        },
      );
      final result = VerifyOTPResponse.fromJson(response);
      //
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<ResetPasswordResponse>> resetPassword(
    String email,
    String password,
    String passwordConfirm,
  ) async {
    String url = API.baseURL;
    try {
      String baseUrl = "$url/patients/password/reset";
      final response = await dioClient.put(
        baseUrl,
        data: {
          'email': email,
          'password': password,
          'passwordConfirm': passwordConfirm,
        },
      );
      final result = ResetPasswordResponse.fromJson(response);
      //
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<ArticleResponse>> getArticle() async {
    String url = API.baseURL;
    String baseUrl = "$url/posts/all";
    final options = Options(
        headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"});
    try {
      final response = await dioClient.get(
        baseUrl,
        options: options,
      );
      final result = ArticleResponse.fromJson(response);
      //
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<PromoResponse>> getPromo() async {
    String url = API.baseURL;
    String baseUrl = "$url/clinic/promo/all";
    final options = Options(
        headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"});
    try {
      final response = await dioClient.get(
        baseUrl,
        options: options,
      );
      final result = PromoResponse.fromJson(response);
      //
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<ClinicResponse>> getClinic() async {
    String url = API.baseURL;
    String baseUrl = "$url/clinic/all";
    final options = Options(
        headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"});
    try {
      final response = await dioClient.get(
        baseUrl,
        options: options,
      );
      final result = ClinicResponse.fromJson(response);
      //
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<ProfileResponse>> getProfile() async {
    String url = API.baseURL;
    String baseUrl = "$url/patients/";
    final options = Options(
        headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"});
    try {
      final response = await dioClient.get(
        baseUrl,
        options: options,
      );
      final result = ProfileResponse.fromJson(response);
      //
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<DoctorResponse>> getDoctor() async {
    String url = API.baseURL;
    String baseUrl = "$url/doctors/all";
    final options = Options(headers: {
      "Authorization": "Bearer ${await TokenManager.getToken()}"
      // eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg2NmM5MzkxLWRiMWEtNDEyOC1hNzA4LWY4YWFkY2RjYzdkNiIsImlhdCI6MTcwODg2Nzg2MCwiZXhwIjoxNzA5NDcyNjYwfQ.ZV8dG_Y3Ynzn1MQcOccWl7Y9W5FZ0CJSKGUbj9CJWN4"
    });
    try {
      final response = await dioClient.get(
        baseUrl,
        options: options,
      );
      final result = DoctorResponse.fromJson(response);
      //
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<SearchDoctorResponse>> searchDoctor(
    String name,
  ) async {
    String url = API.baseURL;
    String baseUrl = "$url/doctors/search?querySearch=$name";
    final options = Options(
        headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"});
    try {
      final response = await dioClient.get(
        baseUrl,
        options: options,
        queryParameters: {
          'name': name,
        },
      );
      final result = SearchDoctorResponse.fromJson(response);
      //
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<ArticleResponse>> searchArticle(
    String article,
  ) async {
    String url = API.baseURL;
    String baseUrl = "$url/posts/search?querySearch=$article";
    final options = Options(
        headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"});
    try {
      final response = await dioClient.get(
        baseUrl,
        options: options,
        queryParameters: {
          'name': article,
        },
      );
      final result = ArticleResponse.fromJson(response);
      //
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<ChangePasswordResponse>> changePassword(
    String oldPassword,
    String newPassword,
    String passwordConfirm,
  ) async {
    String url = API.baseURL;
    final options = Options(
        headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"});
    try {
      String baseUrl = "$url/patients/change-password";
      final response = await dioClient.put(
        baseUrl,
        data: {
          'pass': oldPassword,
          'passNew': newPassword,
          'passConfirm': passwordConfirm,
        },
        options: options,
      );
      final result = ChangePasswordResponse.fromJson(response);
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<UpdateProfileResponse>> updateProfile(
    String name,
    String gender,
    String email,
    String phoneNumber,
    File? image,
  ) async {
    String url = API.baseURL;
    final options = Options(
        headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"});
    FormData formData = FormData.fromMap({
      'name': name,
      'gender': gender,
      'email': email,
      'phoneNumber': phoneNumber,
      'image': await MultipartFile.fromFile(
        image!.path,
        filename: image.path.split('/').last,
        contentType: MediaType('image', 'jpeg, png, jpg'),
      )
    });
    try {
      String baseUrl = "$url/patients/";
      final response = await dioClient.put(
        baseUrl,
        data: formData,
        options: options,
      );
      final result = UpdateProfileResponse.fromJson(response);
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    } catch (error, stackTrace) {
      return ApiResult.failure(
          DioExceptions.fromDioError(DioException(
            requestOptions: RequestOptions(path: ''),
            response: Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 500,
              data: 'Internal server error',
              headers: Headers(),
              isRedirect: false,
              redirects: [],
              // requestOptions: RequestOptions(path: ''),
            ),
          )),
          stackTrace);
    }
  }

  Future<ApiResult<DeleteProfileResponse>> deleteProfile() async {
    String url = API.baseURL;
    final options = Options(
        headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"});
    try {
      String baseUrl = "$url/patients/";
      final response = await dioClient.delete(
        baseUrl,
        options: options,
      );
      final result = DeleteProfileResponse.fromJson(response);
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<DetectionTeethResponse>> detectionTeeth(
    File? image1,
    File? image2,
    File? image3,
  ) async {
    String url = API.baseURL;
    final options = Options(
        headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"});
    FormData formData = FormData();

    // Tambahkan image1 ke FormData
    formData.files.add(MapEntry(
      'image',
      await MultipartFile.fromFile(
        image1!.path,
        filename: image1.path.split('/').last,
        contentType: MediaType('image', 'jpeg, png, jpg'),
      ),
    ));

    // Jika image2 tidak null, tambahkan ke FormData
    if (image2 != null) {
      formData.files.add(MapEntry(
        'image',
        await MultipartFile.fromFile(
          image2.path,
          filename: image2.path.split('/').last,
          contentType: MediaType('image', 'jpeg, png, jpg'),
        ),
      ));
    }

    // Jika image3 tidak null, tambahkan ke FormData
    if (image3 != null) {
      formData.files.add(MapEntry(
        'image',
        await MultipartFile.fromFile(
          image3.path,
          filename: image3.path.split('/').last,
          contentType: MediaType('image', 'jpeg, png, jpg'),
        ),
      ));
    }
    try {
      String baseUrl = "$url/predicts/";
      final response = await dioClient.post(
        baseUrl,
        data: formData,
        options: options,
      );
      final result = DetectionTeethResponse.fromJson(response);
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    } catch (error, stackTrace) {
      return ApiResult.failure(
          DioExceptions.fromDioError(DioException(
            requestOptions: RequestOptions(path: ''),
            response: Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 500,
              data: 'Internal server error',
              headers: Headers(),
              isRedirect: false,
              redirects: [],
              // requestOptions: RequestOptions(path: ''),
            ),
          )),
          stackTrace);
    }
  }

  Future<ApiResult<PaymentConsultationResponse>> paymentConsultation(
    String paymentType,
    int amount,
    int itemId,
    String itemName,
    String consultationPrice,
    String firstName,
    String lastName,
    String email,
    String phone,
    String bankName,
    String photo,
  ) async {
    String url = API.baseURL;
    final options = Options(
        headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"});
    try {
      String baseUrl = "$url/payment/consultation/charge/transfer";
      final response = await dioClient.post(
        baseUrl,
        data: {
          'payment_type': paymentType,
          'amount': amount,
          'itemDetails': {
            'id': itemId,
            'name': itemName,
            'consultationPrice': consultationPrice,
            'photo': photo
          },
          'customer_details': {
            'first_name': firstName,
            'last_name': lastName,
            'email': email,
            'phone': phone,
          },
          'bankName': bankName,
        },
        options: options,
      );
      final result = PaymentConsultationResponse.fromJson(response);
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<CheckPaymentConsultationResponse>> getStatusPaymentConsultation(
    String orderId,
    String transactionId,
  ) async {
    String url = API.baseURL;
    final options = Options(headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"});
    try {
      String baseUrl = "$url/payment/consultation/charge/status";
      final response = await dioClient.post(
        baseUrl,
        data: {
          "orderId": orderId,
          "transaction_id": transactionId,
        },
        options: options,
      );
      final result = CheckPaymentConsultationResponse.fromJson(response);
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<dynamic>> createHistoryChat({required String orderId, required String idRoomChat}) async {
    String url = API.baseURL;
    final options = Options(headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"});
    try {
      final baseUrl = '$url/consultations/history';
      final response = await dioClient.post(
        baseUrl,
        options: options,
        data: {
          'orderId': orderId,
          'idRoomChat': idRoomChat
        }
      );
      return ApiResult.success(response);
    } on DioException catch(e, st) {
      return ApiResult.failure(DioExceptions.fromDioError(e), st);
    }
  }

  Future<ApiResult<GetConsultationHistoryResponse>> getConsultationHistory({required String orderId}) async {
    String url = API.baseURL;
    final options = Options(headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"});
    try {
      final baseUrl = '$url/consultations/history/$orderId';
      final response = await dioClient.get(
        baseUrl,
        options: options,
      );
      return ApiResult.success(GetConsultationHistoryResponse.fromJson(response));
    } on DioException catch(e, st) {
      return ApiResult.failure(DioExceptions.fromDioError(e), st);
    }
  }

  Future<ApiResult<CheckPaymentBookingDoctorResponse>> getStatusPaymentBookingDoctor(
    String orderId,
    String transactionId,
  ) async {
    String url = API.baseURL;
    final options = Options(
        headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"});
    try {
      String baseUrl = "$url/payment/clinicbooking/charge/status";
      final response = await dioClient.post(
        baseUrl,
        options: options,
        data: {
          "orderId": orderId,
          "transaction_id": transactionId,
        },
      );
      final result = CheckPaymentBookingDoctorResponse.fromJson(response);
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<DetailClinicResponse>> detailClinicById(int id) async {
    String url = API.baseURL;
    final options = Options(headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"});
    try {
      String baseUrl = "$url/clinic/$id";
      final response = await dioClient.get(
        baseUrl,
        options: options,
      );
      final result = DetailClinicResponse.fromJson(response);
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<PaymentBookingDoctorResponse>> bookingDoctor(
      String paymentType,
      int amount,
      int idClinic,
      int idDoctor,
      int idPatient,
      String clinicName,
      String doctorName,
      String doctorSpecialization,
      String date,
      String startTime,
      String endTime,
      List<int> idServices,
      List<String> servicesName,
      List<String> servicesPrice,
      String statusService,
      String statusBooking,
      String firstName,
      String lastName,
      String email,
      String phone,
      String bankName,
      String photo,
      {bool isCOD = false}
    ) async {
    String url = API.baseURL;
    final options = Options(
      headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"},
    );
    try {
      String baseUrl = '';
      if(!isCOD) {
        baseUrl = "$url/payment/clinicbooking/charge/transfer";
      } else {
        baseUrl = "$url/payment/clinicbooking/charge/offline";
      }

      final response = await dioClient.post(
        baseUrl,
        data: {
          "payment_type": paymentType,
          'amount': amount,
          'itemDetails': {
            "idClinic": idClinic,
            "idDoctor": idDoctor,
            "idPatient": idPatient,
            'clinicName': clinicName,
            'doctorName': doctorName,
            'doctorSpecialization': doctorSpecialization,
            'photo': photo,
            'date': date,
            'startTime': startTime,
            'endTime': endTime,
            'idServices': idServices,
            'servicesName': servicesName,
            'servicesPrice': servicesPrice,
            'statusService': statusService,
            'statusBooking': statusBooking,
          },
          'customer_details': {
            'first_name': firstName,
            'last_name': lastName,
            'email': email,
            'phone': phone,
          },
          if(!isCOD) 'bankName': bankName,
        },
        options: options,
      );
      final result = PaymentBookingDoctorResponse.fromJson(response);
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<HistoryConsultationResponse>>
      getHistoryConsultation() async {
    String url = API.baseURL;
    String baseUrl = "$url/payment/consultation/charge/history";
    final options = Options(
        headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"});
    try {
      final response = await dioClient.get(
        baseUrl,
        options: options,
      );
      final result = HistoryConsultationResponse.fromJson(response);
      //
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<HistoryBookingClinicResponse>>
      getHistoryBookingClinic() async {
    String url = API.baseURL;
    String baseUrl = "$url/payment/clinicbooking/charge/history";
    final options = Options(
        headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"});
    try {
      final response = await dioClient.get(
        baseUrl,
        options: options,
      );
      final result = HistoryBookingClinicResponse.fromJson(response);
      //
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }

  Future<ApiResult<ClinicResponse>> searchClinic(
    String name,
  ) async {
    String url = API.baseURL;
    String baseUrl = "$url/clinic/search?querySearch=$name";
    final options = Options(
        headers: {"Authorization": "Bearer ${await TokenManager.getToken()}"});
    try {
      final response = await dioClient.get(
        baseUrl,
        options: options,
        queryParameters: {
          'name': name,
        },
      );
      final result = ClinicResponse.fromJson(response);
      //
      return ApiResult.success(result);
    } on DioException catch (e, stackTrace) {
      return ApiResult.failure(DioExceptions.fromDioError(e), stackTrace);
    }
  }
}
