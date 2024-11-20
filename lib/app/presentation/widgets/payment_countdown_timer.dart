import 'dart:async';

import 'package:flutter/material.dart';

class PaymentCountDownTimer extends StatefulWidget {
  final DateTime expiryDate;
  final VoidCallback onTimesUp;
  const PaymentCountDownTimer({required this.expiryDate, required this.onTimesUp, super.key});

  @override
  State<PaymentCountDownTimer> createState() => _PaymentCountDownTimerState();
}

class _PaymentCountDownTimerState extends State<PaymentCountDownTimer> {

  late Duration _remainingTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.expiryDate.difference(DateTime.now());
    _startTimer();
  }

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        final now = DateTime.now();
        if (now.isBefore(widget.expiryDate)) {
          _remainingTime = widget.expiryDate.difference(now);
        } else {
          _remainingTime = Duration.zero;
          timer.cancel();
          widget.onTimesUp();
        }
      });
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 246, 174, 191),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Selesaikan Pembayaran dalam',
            style: TextStyle(color: Color.fromARGB(255, 179, 18, 6),
            ),
          ),
          Text(
            _formatDuration(_remainingTime),
            style: TextStyle(
              color: Color.fromARGB(255, 179, 18, 6),
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

}
