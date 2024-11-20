import 'package:GoDentist/app/presentation/controllers/c_article.dart';
import 'package:GoDentist/app/presentation/controllers/c_doctor.dart';
import 'package:GoDentist/app/presentation/screen/education/education_screen.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:GoDentist/app/utils/extensions/string_extension.dart';
import 'package:GoDentist/app/utils/tools.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../../common/routes/app_pages.dart';
import '../../../utils/shared/dot_indicator.dart';
import '../../controllers/c_clinic.dart';
import '../../controllers/c_home.dart';
import '../doctor/payment_screen.dart';
import '../education/detail_education_screen.dart';
import 'detail_clinic_screen.dart';
import 'detail_promo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final cHome = Get.put(CHome());
  final cClinic = Get.put(CClinic());
  final cDoctor = Get.put(CDoctor());
  final cArticle = Get.put(CArticle());

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            header(context),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  cHome.getLocation();
                  cHome.getProfile();
                  cHome.getClinic();
                  cHome.getPromo();
                  cDoctor.getDoctor();
                  cArticle.getArticle();
                },
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      banner(context),
                      SizedBox(height: 16,),
                      promo(context),
                      SizedBox(height: 22,),
                      clinic(context),
                      SizedBox(height: 22,),
                      doctor(context),
                      SizedBox(height: 22,),
                      article(context),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1))
      ),
      child: Row(
        children: [
          Image.asset('assets/images/Logo2.png', width: 100,),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            constraints: BoxConstraints(
              maxWidth: isTabletMode(context) ? 300 : 146
            ),
            decoration: BoxDecoration(
              border: Border.all(color: ColorConstant.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text.rich(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              TextSpan(
                children: [
                  TextSpan(text: "Hai, "),
                  TextSpan(text: cHome.profileResponse.data?.name, style: TextStyle(fontWeight: FontWeight.w600))
                ]
              )
            ),
          ),
          SizedBox(width: 10,),
          SvgPicture.asset('assets/icons/notification.svg')
        ],
      ),
    );
  }

  Widget banner(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/banner_home.png', height: isTabletMode(context) ? 280 : null, fit: BoxFit.cover, width: double.infinity,),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 24,),
                const Text("Ayo Periksa Kesehatan Gigi Anda", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),),
                const Text("Sekarang Juga !", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),),
                SizedBox(height: 18,),
                Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[300]!, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.doctor);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: ColorConstant.primaryColor,
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
                      ),
                      Expanded(
                        child: GestureDetector(
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
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.detection);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: ColorConstant.primaryColor,
                                child: Image.asset(
                                  "assets/images/tooth1.png",
                                  width: 120.0,
                                  height: 120.0,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Deteksi\nGigi',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.blackColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.reminder);
                          },
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorConstant.primaryColor,
                                radius: 30,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Image.asset(
                                    "assets/images/atur_pengingat_icon.png",
                                    width: 120.0,
                                    height: 120.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Atur\nPengingat',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.blackColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget promo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Promo Eksklusif Untuk Anda", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
          SizedBox(height: 2,),
          Text("Nikmati promo spesial untuk perawatan gigi anda.", style: TextStyle(color: Colors.grey[500], fontSize: 14),),
          SizedBox(height: 12,),
          Obx(() => cHome.isFetching
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
                : Stack(
                  children: [
                    CarouselSlider(
                      carouselController: CarouselController(),
                      options: CarouselOptions(
                        height: 220,
                        viewportFraction: 1,
                        enableInfiniteScroll: true,
                        scrollDirection: Axis.horizontal,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 4),
                        autoPlayAnimationDuration:
                        Duration(milliseconds: 800),
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
                            Get.to(DetailPromoScreen(data: i,),);
                          },
                          child: Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  image: DecorationImage(
                                    image: NetworkImage(i.photo ?? "https://via.placeholder.com/150"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList() ?? [],
                    ),
                    if(cHome.promoResponse.data != null)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding:
                        const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(
                            cHome.promoResponse.data!.length, (index) {
                            return dotIndicator(
                              10,
                              currentIndex == index ? ColorConstant.primaryColor : Colors.grey[300]!,
                            );
                          },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          ),
        ],
      ),
    );
  }

  Widget clinic(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Rekomendasi Klinik Terdekat", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
          SizedBox(height: 2,),
          Text("Temukan Perawatan gigi terdekat dan terbaik untuk anda", style: TextStyle(color: Colors.grey[500], fontSize: 14),),
          SizedBox(height: 12,),
          Obx(() => cHome.isFetching
              ? ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
              : cHome.clinicResponse.data != null && cHome.clinicResponse.data!.isNotEmpty
              ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  cHome.clinicResponse.data!.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => DetailClinicScreen(id: cHome.clinicResponse.data![index].id ?? 0,),);
                        cClinic.detailClinicById(cHome.clinicResponse.data![index].id ?? 0,);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 16),
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300]!, width: 1)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(14), topLeft: Radius.circular(14)),
                              child: FadeInImage.assetNetwork(
                                height: 106,
                                width: double.infinity,
                                placeholderFit: BoxFit.cover,
                                placeholder: 'assets/images/blank.jpeg',
                                image: cHome.clinicResponse.data![index].photoUrl ?? 'https://cdn4.vectorstock.com/i/1000x1000/58/48/blank-photo-icon-vector-3265848.jpg',
                                fit: BoxFit.cover,
                                imageErrorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/blank.jpeg',
                                    height: 106,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8),
                                  Text(
                                    "${cHome.clinicResponse.data![index].name}\n\n",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: ColorConstant.blackColor,
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Icon(Icons.access_time_rounded, size: 14, color: Colors.grey,),
                                      SizedBox(width: 4,),
                                      Text(
                                        "${cHome.clinicResponse.data![index].open} - ${cHome.clinicResponse.data![index].closed}",
                                        style: TextStyle(
                                          color: ColorConstant.blackColor,
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      SvgPicture.asset('assets/icons/home-add.svg', width: 14,),
                                      SizedBox(width: 4,),
                                      Expanded(
                                        child: Text(
                                          cHome.clinicResponse.data![index].address ?? "",
                                          style: TextStyle(
                                            color: ColorConstant.blackColor,
                                            fontSize: 12,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ) : SizedBox(), // Tampilkan widget kosong jika data clinic null atau kosong
          ),
          SizedBox(height: 16,),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.primaryColor.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0
              ),
              onPressed: () {
                Get.toNamed(Routes.listClinic);
              },
              child: Text("Lihat Semua Klinik"),
            ),
          )
        ],
      ),
    );
  }

  Widget doctor(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Chat Konsultasi Dengan Dokter Gigi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
          SizedBox(height: 2,),
          Text("Konsultasikan masalah kesehatan gigi anda dimana saja", style: TextStyle(color: Colors.grey[500], fontSize: 14),),
          SizedBox(height: 12,),
          Obx(() => cDoctor.isFetching
            ? Container()
            : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...?cDoctor.doctorResponse.data?.map((e) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(PaymentScreen(doctor: e));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 16),
                      padding: EdgeInsets.all(16),
                      width: 260,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  e.photo.toString(),
                                  height: 90,
                                  width: 75,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 75,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey[200]
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 12,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(e.name.toString(), style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, letterSpacing: 0.1),),
                                    SizedBox(height: 2,),
                                    Text(e.specialization.toString(), style: TextStyle(color: Colors.grey[500], letterSpacing: 0.1),),
                                    SizedBox(height: 2,),
                                    Wrap(
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle
                                          ),
                                        ),
                                        SizedBox(width: 4,),
                                        Text("Online", style: TextStyle(color: Colors.green, fontSize: 14, letterSpacing: 0.1),)
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 12,),
                          Container(
                            height: 1,
                            color: Colors.grey[200],
                          ),
                          SizedBox(height: 12,),
                          if(e.consultationPrice != null)
                            Text("Biaya Konsultasi"),
                          if(e.consultationPrice != null)
                            Text(
                              NumberFormat.currency(locale: 'id', symbol: 'Rp.', decimalDigits: 0).format(int.parse(e.consultationPrice!)),
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: ColorConstant.primaryColor),
                            )
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          )
          ),
          SizedBox(height: 16,),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryColor.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0
              ),
              onPressed: () {
                Get.toNamed(Routes.doctor);
              },
              child: Text("Lihat Semua Dokter"),
            ),
          )
        ],
      ),
    );
  }

  Widget article(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Artikel Edukasi Untukmu", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
          SizedBox(height: 12,),
          Obx(() => cArticle.isFetching
              ? Container()
              : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...?cArticle.articleResponse.data?.map((e) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(DetailEducationScreen(data: e,));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 16),
                      width: 260,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
                            child: Image.network(
                              e.photoUrl.toString(),
                              fit: BoxFit.cover,
                              height: 100,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${e.category!.name.toString().toCamelCase()}\n", style: TextStyle(color: ColorConstant.primaryColor, fontSize: 12, letterSpacing: 0.1), maxLines: 1, overflow: TextOverflow.ellipsis),
                                SizedBox(height: 4,),
                                Text("${e.title}\n\n", style: TextStyle(fontWeight: FontWeight.w500), maxLines: 2, overflow: TextOverflow.ellipsis)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          )
          ),
          SizedBox(height: 16,),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryColor.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0
              ),
              onPressed: () {
                Get.to(EducationScreen());
              },
              child: Text("Lihat Semua Artikel"),
            ),
          )
        ],
      ),
    );
  }

}
