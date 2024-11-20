import 'package:GoDentist/app/data/models/articles/article_response.dart';
import 'package:GoDentist/app/presentation/controllers/c_article.dart';
import 'package:GoDentist/app/presentation/screen/education/detail_education_screen.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cArticle = Get.put(CArticle());

    Widget buildArticleCard(Datum article) {
      return GestureDetector(
        onTap: () {
          Get.to(
            DetailEducationScreen(
              data: article,
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
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
                  children: [
                    article.photoUrl != null
                        ? Image.network(
                            article.photoUrl ?? "",
                            width: 120.0,
                            height: 120.0,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/images/education.png",
                            width: 120.0,
                            height: 120.0,
                            fit: BoxFit.cover,
                          ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.title ?? "title",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ColorConstant.blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            article.description ?? "description",
                            textAlign: TextAlign.justify,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
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
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Edukasi Kesehatan Gigi',
          style: TextStyle(
            color: ColorConstant.blackColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          cArticle.getArticle();
        },
        child: Column(
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: cArticle.searchQuery,
                decoration: InputDecoration(
                  hintText: 'Cari Edukasi Kesehatan Gigi',
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
                  cArticle.searchArticle(value);
                },
              ),
            ),
            SizedBox(height: 8),
            Obx(() {
              if (cArticle.isFetching) {
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 130,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          width: double.infinity,
                          // margin:
                          //     EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          // padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (cArticle.searchQuery.text.isEmpty) {
                return Expanded(
                  child: cArticle.articleResponse.data != null &&
                          cArticle.articleResponse.data!.isEmpty
                      ? ListView.builder(
                          itemCount: cArticle.articleResponse.data!.length,
                          itemBuilder: (context, index) {
                            return buildArticleCard(
                                cArticle.articleResponse.data![index]);
                          },
                        )
                      : Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            itemCount: cArticle.articleResponse.data?.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    DetailEducationScreen(
                                      data:
                                          cArticle.articleResponse.data![index],
                                    ),
                                  );
                                },
                                child: Container(
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 16),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.4),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            cArticle.articleResponse.data![index].photoUrl != null
                                                ? ClipRRect(
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                                                  child: Image.network(
                                                      cArticle.articleResponse.data?[index].photoUrl ?? "",
                                                      width: 130.0,
                                                      height: 120.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                )
                                                : ClipRRect(
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                                                  child: Image.asset(
                                                      "assets/images/education.png",
                                                      width: 120.0,
                                                      height: 120.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      cArticle.articleResponse.data?[index].title ?? "title",
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                        color: ColorConstant.blackColor,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(height: 8),
                                                    Text(
                                                      cArticle
                                                          .articleResponse
                                                          .data?[index]
                                                          .description ?? "description",
                                                      textAlign:
                                                      TextAlign.justify,
                                                      maxLines: 3,
                                                      overflow: TextOverflow.ellipsis,
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
                                      ),
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
                  child: cArticle.articleResponse.data!.isEmpty
                      ? Center(
                          child: Text('Pencarian tidak ditemukan'),
                        )
                      : ListView.builder(
                          itemCount: cArticle.articleResponse.data!.length,
                          itemBuilder: (context, index) {
                            return buildArticleCard(
                                cArticle.articleResponse.data![index]);
                          },
                        ),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
