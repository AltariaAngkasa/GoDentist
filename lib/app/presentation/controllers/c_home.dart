import 'package:GoDentist/app/data/models/clinic/clinic_response.dart';
import 'package:GoDentist/app/data/models/profile/profile_response.dart';
import 'package:GoDentist/app/data/models/promo/promo_response.dart';
import 'package:GoDentist/app/data/network/api_service.dart';
import 'package:GoDentist/app/presentation/controllers/c_common.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CHome extends CCommon {
  final apiService = ApiService();

  final Rx<PromoResponse> _promoResponse = PromoResponse().obs;
  PromoResponse get promoResponse => _promoResponse.value;
  set promoResponse(PromoResponse newValue) {
    _promoResponse.value = newValue;
  }

  final Rx<ClinicResponse> _clinicResponse = ClinicResponse().obs;
  ClinicResponse get clinicResponse => _clinicResponse.value;
  set clinicResponse(ClinicResponse newValue) {
    _clinicResponse.value = newValue;
  }

  final Rx<ProfileResponse> _profileResponse = ProfileResponse().obs;
  ProfileResponse get profileResponse => _profileResponse.value;
  set profileResponse(ProfileResponse newValue) {
    _profileResponse.value = newValue;
  }

  RxString location = ''.obs;

  Future<void> getLocation() async {
    try {
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      // Mendapatkan alamat dari koordinat latitude dan longitude
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        // Mengupdate nilai lokasi dengan alamat yang didapat
        location.value = placemark.locality ?? "";
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future getPromo() async {
    isFetching = true;
    final result = await apiService.getPromo();
    result.when(
      success: (data) {
        promoResponse = data;
        isSuccessfull = true;
        isFetching = false;
        message = promoResponse.message ?? "Successfull get promo";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }

  Future getClinic() async {
    isFetching = true;
    final result = await apiService.getClinic();
    result.when(
      success: (data) {
        clinicResponse = data;
        isSuccessfull = true;
        isFetching = false;

        // print(clinicResponse.toJson());
        message = clinicResponse.message ?? "Successfull get Clinic";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }

  Future getProfile() async {
    isFetching = true;
    final result = await apiService.getProfile();
    result.when(
      success: (data) {
        profileResponse = data;
        isSuccessfull = true;
        isFetching = false;

        // print(clinicResponse.toJson());
        message = profileResponse.message ?? "Successfull get Profile";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }

  @override
  void onInit() async {
    await getPromo();
    await getClinic();
    await getProfile();
    await getLocation();
    super.onInit();
  }
}
