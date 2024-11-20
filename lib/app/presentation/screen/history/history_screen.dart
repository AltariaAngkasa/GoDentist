import 'package:GoDentist/app/presentation/screen/history/list_booking_history_screen.dart';
import 'package:GoDentist/app/presentation/screen/history/list_consultation_history_screen.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = TabController(length: 2, vsync: Scaffold.of(context));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Riwayat Transaksi',
          style: TextStyle(
            color: ColorConstant.blackColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          labelColor: ColorConstant.blackColor,
          indicatorColor: ColorConstant.primaryColor,
          controller: tabController,
          tabs: const [
            Tab(
              text: 'Booking',
            ),
            Tab(
              text: 'Konsultasi',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          ListBookingHistoryScreen(),
          ListConsultationHistoryScreen()
        ],
      ),
    );
  }
}
