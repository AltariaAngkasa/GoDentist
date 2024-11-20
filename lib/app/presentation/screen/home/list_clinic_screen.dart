import 'package:GoDentist/app/presentation/controllers/c_clinic.dart';
import 'package:GoDentist/app/presentation/screen/home/detail_clinic_screen.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ListClinicScreen extends StatelessWidget {
  const ListClinicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final cHome = Get.put(CHome());
    final cClinic = Get.put(CClinic());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Booking Klinik Gigi',
          style: TextStyle(
            color: ColorConstant.blackColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorConstant.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
            cClinic.searchQuery.clear();
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          cClinic.cHome.getClinic();
        },
        child: Column(
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: cClinic.searchQuery,
                decoration: InputDecoration(
                  hintText: 'Cari Rumah Sakit / Klinik Gigi',
                  hintStyle: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: ColorConstant.primaryColor,
                  ),
                  contentPadding: EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                ),
                onChanged: (value) {
                  cClinic.searchClinic(value);
                },
              ),
            ),
            SizedBox(height: 16),
            Obx(() {
              if (cClinic.isFetching || cClinic.cHome.isFetching) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 190,
                          margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (cClinic.searchQuery.text.isEmpty) {
                return Expanded(
                  child: cClinic.cHome.clinicResponse.data != null
                      ? ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          itemCount: cClinic.cHome.clinicResponse.data!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => DetailClinicScreen(
                                  id: cClinic.cHome.clinicResponse.data![index].id ?? 0),
                                );
                                cClinic.detailClinicById(
                                  cClinic.cHome.clinicResponse.data![index].id ?? 0,
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 16),
                                padding: EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
                                      child: FadeInImage.assetNetwork(
                                        height: 106,
                                        width: double.infinity,
                                        placeholderFit: BoxFit.cover,
                                        placeholder: 'assets/images/blank.jpeg',
                                        image: cClinic.cHome.clinicResponse.data![index].photoUrl ??
                                            'https://cdn4.vectorstock.com/i/1000x1000/58/48/blank-photo-icon-vector-3265848.jpg',
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
                                    SizedBox(height: 8),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 24),
                                        child: Text(
                                          cClinic.cHome.clinicResponse.data![index].name ?? "",
                                          style: TextStyle(
                                            color: ColorConstant.blackColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 24),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          cClinic.cHome.clinicResponse
                                                  .data![index].open ??
                                              "",
                                          style: TextStyle(
                                            color: ColorConstant.blackColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                        child: Text(
                                          cClinic.cHome.clinicResponse
                                                  .data![index].address ??
                                              "",
                                          style: TextStyle(
                                            color: ColorConstant.blackColor,
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
                        )
                      : Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            itemCount: cClinic.cHome.clinicResponse.data?.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => DetailClinicScreen(
                                    id: cClinic.cHome.clinicResponse.data![index].id ?? 0,
                                  ));
                                  cClinic.detailClinicById(
                                    cClinic.cHome.clinicResponse.data![index].id ?? 0,
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      FadeInImage.assetNetwork(
                                        height: 106,
                                        width: double.infinity,
                                        placeholderFit: BoxFit.cover,
                                        placeholder: 'assets/images/blank.jpeg',
                                        image: cClinic.cHome.clinicResponse.data![index].photoUrl ??
                                            'https://cdn4.vectorstock.com/i/1000x1000/58/48/blank-photo-icon-vector-3265848.jpg',
                                        fit: BoxFit.cover,
                                        imageErrorBuilder: (context, error, stackTrace) {
                                          return Image.asset(
                                            'assets/images/blank.jpeg',
                                            height: 106,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                      SizedBox(height: 8),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: Text(
                                            cClinic.cHome.clinicResponse
                                                    .data![index].name ??
                                                "",
                                            style: TextStyle(
                                              color: ColorConstant.blackColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            cClinic.cHome.clinicResponse
                                                    .data![index].open ??
                                                "",
                                            style: TextStyle(
                                              color: ColorConstant.blackColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: Text(
                                            cClinic.cHome.clinicResponse
                                                    .data![index].address ??
                                                "",
                                            style: TextStyle(
                                              color: ColorConstant.blackColor,
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
                );
              } else {
                return Expanded(
                    child: cClinic.cHome.clinicResponse.data!.isEmpty
                        ? Center(
                            child: Text('Pencarian tidak ditemukan'),
                          )
                        : ListView.builder(
                            itemCount:
                                cClinic.cHome.clinicResponse.data!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => DetailClinicScreen(
                                      id: cClinic.cHome.clinicResponse
                                              .data![index].id ??
                                          0));
                                  cClinic.detailClinicById(
                                    cClinic.cHome.clinicResponse.data![index]
                                            .id ??
                                        0,
                                  );
                                  // print(cClinic
                                  //     .cHome.clinicResponse.data![index].id!);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: 16, left: 16, right: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
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
                                        placeholderFit: BoxFit.cover,
                                        placeholder: 'assets/images/blank.jpeg',
                                        image: cClinic.cHome.clinicResponse
                                                .data![index].photoUrl ??
                                            'https://cdn4.vectorstock.com/i/1000x1000/58/48/blank-photo-icon-vector-3265848.jpg',
                                        fit: BoxFit.cover,
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
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
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: Text(
                                            cClinic.cHome.clinicResponse
                                                    .data![index].name ??
                                                "",
                                            style: TextStyle(
                                              color: ColorConstant.blackColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            cClinic.cHome.clinicResponse
                                                    .data![index].open ??
                                                "",
                                            style: TextStyle(
                                              color: ColorConstant.blackColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: Text(
                                            cClinic.cHome.clinicResponse
                                                    .data![index].address ??
                                                "",
                                            style: TextStyle(
                                              color: ColorConstant.blackColor,
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
                          ));
              }
            }),
          ],
        ),
      ),
    );
  }
}
