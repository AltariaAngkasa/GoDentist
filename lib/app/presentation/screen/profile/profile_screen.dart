import 'package:GoDentist/app/common/routes/app_pages.dart';
import 'package:GoDentist/app/presentation/controllers/c_home.dart';
import 'package:GoDentist/app/presentation/controllers/c_profile.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cHome = Get.put(CHome());
    final cProfile = Get.put(CProfile());
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Profil Pengguna',
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
            },
          )),
      body: RefreshIndicator(
        onRefresh: () async {
          cHome.getProfile();
        },
        child: ListView(
          children: [
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(16, 30, 16, 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Obx(() => CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                                cHome.profileResponse.data?.photo ??
                                    "https://via.placeholder.com/150"),
                          )),
                      SizedBox(width: 32),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: ColorConstant.primaryColor,
                              ),
                              SizedBox(width: 16),
                              Obx(
                                () => Text(
                                  cHome.profileResponse.data?.name != null &&
                                          cHome.profileResponse.data!.name!
                                                  .length >
                                              15
                                      ? "${cHome.profileResponse.data!.name!.substring(0, 15)}..."
                                      : cHome.profileResponse.data?.name ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.face,
                                    color: ColorConstant.primaryColor,
                                  ),
                                  SizedBox(width: 16),
                                  Obx(() => Text(
                                        cHome.profileResponse.data?.gender ??
                                            "",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 12),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    color: ColorConstant.primaryColor,
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    cHome.profileResponse.data?.email != null &&
                                            cHome.profileResponse.data!.email!
                                                    .length >
                                                15
                                        ? "${cHome.profileResponse.data!.email!.substring(0, 12)}..."
                                        : cHome.profileResponse.data?.email ??
                                            "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 12),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: ColorConstant.primaryColor,
                                  ),
                                  SizedBox(width: 16),
                                  Obx(() => Text(
                                        cHome.profileResponse.data
                                                ?.phoneNumber ??
                                            "",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(Routes.updateProfile),
                      child: Text(
                        "Ubah",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ganti Password',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.toNamed(Routes.changePassword);
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Hapus Akun'),
                      content: Text(
                          'Apakah anda yakin ingin menghapus akun anda? jika iya, data yang sudah dihapus tidak bisa dikembalikan lagi'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () {
                            cProfile.deleteProfile();
                          },
                          child: Text('Hapus'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'Hapus Akun',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: ColorConstant.redColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
