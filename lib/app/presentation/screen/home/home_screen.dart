import 'package:GoDentist/app/common/routes/app_pages.dart';
import 'package:GoDentist/app/presentation/controllers/c_clinic.dart';
import 'package:GoDentist/app/presentation/controllers/c_home.dart';
import 'package:GoDentist/app/presentation/screen/home/detail_clinic_screen.dart';
import 'package:GoDentist/app/presentation/screen/home/detail_promo_screen.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:GoDentist/app/utils/shared/dot_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final cHome = Get.put(CHome());
    final cClinic = Get.put(CClinic());
    Widget header() {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        // height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Obx(
                          () => cHome.location.isEmpty
                          ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 6),
                          height: 16,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      )
                          : Text(
                        'Lokasi Anda',
                        style: TextStyle(
                          color: ColorConstant.primaryColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Obx(
                          () => cHome.location.isEmpty
                          ? SizedBox()
                          : Icon(
                        Icons.location_on,
                        color: ColorConstant.redColor,
                        size: 12,
                      ),
                    ),
                  ],
                ),
                Obx(() => cHome.location.isEmpty
                    ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 16,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                )
                    : Text(
                  cHome.location.value,
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ],
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Obx(
                          () => cHome.profileResponse.data?.name == null
                          ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 6),
                          height: 16,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      )
                          : Text(
                        'Selamat Datang',
                        style: TextStyle(
                          color: ColorConstant.primaryColor,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Obx(() => cHome.profileResponse.data?.name == null
                        ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 22,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    )
                        : Text(
                      cHome.profileResponse.data?.name ?? "",
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ],
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.profile);
                  },
                  child: Obx(() => CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                      cHome.profileResponse.data?.photo ??
                          "https://via.placeholder.com/150",
                    ),
                  )),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            cHome.getLocation();
            cHome.getProfile();
            cHome.getClinic();
            cHome.getPromo();
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          header(),
                          Obx(
                                () => cHome.isFetching
                                ? Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                // margin: EdgeInsets.only(bottom: 6),
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            )
                                : Image.asset(
                              'assets/images/frame.png',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 100),
                          // cHome.promoResponse.data?.isEmpty ?? true
                          //     ? SizedBox()
                          //     :
                          Obx(
                                () => cHome.isFetching
                                ? Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                margin:
                                EdgeInsets.symmetric(horizontal: 16),
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            )
                                : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16),
                              child: Text(
                                'Jangan Lewatkan Penawaran Terbaik Ini',
                                style: TextStyle(
                                  color: ColorConstant.blackColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // cHome.promoResponse.data?.isEmpty ?? true
                          //     ? SizedBox()
                          //     : SizedBox(height: 16),
                          // cHome.promoResponse.data?.isEmpty ?? true
                          //     ?
                          SizedBox(height: 16),
                          //     :
                          Obx(
                                () => cHome.isFetching
                                ? Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                margin:
                                EdgeInsets.symmetric(horizontal: 16),
                                height: 170,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            )
                                : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: CarouselSlider(
                                carouselController: carousel_slider.CarouselController(),
                                options: CarouselOptions(
                                  height: 170,
                                  viewportFraction: 1,
                                  enableInfiniteScroll: true,
                                  scrollDirection: Axis.horizontal,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 4),
                                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                  },
                                ),
                                items: cHome.promoResponse.data?.map((i) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(
                                        DetailPromoScreen(
                                          data: i,
                                        ),
                                      );
                                    },
                                    child: Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          width: MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage(i.photo ?? "https://via.placeholder.com/150"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: List.generate(
                                                cHome.promoResponse.data!.length,
                                                    (index) {
                                                  return dotIndicator(
                                                    10,
                                                    currentIndex == index
                                                        ? ColorConstant.primaryColor
                                                        : Colors.grey,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }).toList() ?? [],
                              ),
                            ),


                          ),
                          // cHome.promoResponse.data?.isEmpty ?? true
                          //     ? SizedBox()
                          //     :
                          SizedBox(height: 32),
                          Obx(
                                () => cHome.isFetching
                                ? Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                margin:
                                EdgeInsets.symmetric(horizontal: 16),
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            )
                                : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16),
                              child: Text(
                                'Rekomendasi Klinik Gigi GoDentist',
                                style: TextStyle(
                                  color: ColorConstant.blackColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Obx(
                                () => cHome.isFetching
                                ? ListView.builder(
                              itemCount: 5,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    height: 240,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(5),
                                    ),
                                  ),
                                );
                              },
                            )
                                : cHome.clinicResponse.data != null &&
                                cHome.clinicResponse.data!.isNotEmpty
                                ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  cHome.clinicResponse.data!.length,
                                      (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(
                                              () => DetailClinicScreen(
                                            id: cHome
                                                .clinicResponse
                                                .data![index]
                                                .id ??
                                                0,
                                          ),
                                        );
                                        cClinic.detailClinicById(
                                          cHome.clinicResponse
                                              .data![index].id ??
                                              0,
                                        );
                                        // print(
                                        //   cHome.clinicResponse
                                        //           .data![index].id ??
                                        //       0,
                                        // );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 16),
                                        width: 300,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(
                                              5),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey
                                                  .withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            FadeInImage.assetNetwork(
                                              height: 106,
                                              width: double.infinity,
                                              placeholderFit:
                                              BoxFit.cover,
                                              placeholder:
                                              'assets/images/blank.jpeg',
                                              image: cHome
                                                  .clinicResponse
                                                  .data![index]
                                                  .photoUrl ??
                                                  'https://cdn4.vectorstock.com/i/1000x1000/58/48/blank-photo-icon-vector-3265848.jpg',
                                              fit: BoxFit.cover,
                                              imageErrorBuilder:
                                                  (context, error,
                                                  stackTrace) {
                                                print(
                                                    'Error loading profile image: $error');
                                                return Image.asset(
                                                  'assets/images/blank.jpeg',
                                                  height: 106,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                            SizedBox(height: 8),
                                            Align(
                                              alignment:
                                              Alignment.topLeft,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                    24),
                                                child: Text(
                                                  cHome
                                                      .clinicResponse
                                                      .data![
                                                  index]
                                                      .name ??
                                                      "",
                                                  style: TextStyle(
                                                    color: ColorConstant
                                                        .blackColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 24),
                                              child: Align(
                                                alignment:
                                                Alignment.topLeft,
                                                child: Text(
                                                  "${cHome.clinicResponse.data![index].open} - ${cHome.clinicResponse.data![index].closed}",
                                                  style: TextStyle(
                                                    color: ColorConstant
                                                        .blackColor,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Align(
                                              alignment:
                                              Alignment.topLeft,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                    24),
                                                child: Text(
                                                  cHome
                                                      .clinicResponse
                                                      .data![
                                                  index]
                                                      .address ??
                                                      "",
                                                  style: TextStyle(
                                                    color: ColorConstant
                                                        .blackColor,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                                : SizedBox(), // Tampilkan widget kosong jika data clinic null atau kosong
                          ),
                        ],
                      ),
                    ),
                    Obx(
                          () => cHome.isFetching
                          ? SizedBox()
                          : Positioned(
                        top: MediaQuery.of(context).size.height / 4.5,
                        left: 16,
                        right: 16,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.doctor);
                                },
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor:
                                      ColorConstant.primaryColor,
                                      child: Image.asset(
                                        "assets/images/advice1.png",
                                        width: 120.0,
                                        height: 120.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Konsultasi\nDokter Gigi',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ColorConstant.blackColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.detection);
                                },
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor:
                                      ColorConstant.primaryColor,
                                      child: Image.asset(
                                        "assets/images/tooth1.png",
                                        width: 120.0,
                                        height: 120.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Deteksi\nKesehatan Gigi',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ColorConstant.blackColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.listClinic);
                                },
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor:
                                      ColorConstant.primaryColor,
                                      child: Image.asset(
                                        "assets/images/dental-checkup1.png",
                                        width: 120.0,
                                        height: 120.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Booking\nKlinik Gigi',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ColorConstant.blackColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
