import 'dart:math';

// ignore: import_of_legacy_library_into_null_safe
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

class EmiWithRepaymentHoliday extends StatefulWidget {
  const EmiWithRepaymentHoliday({super.key});

  @override
  _EmiWithRepaymentHolidayState createState() =>
      _EmiWithRepaymentHolidayState();
}

class _EmiWithRepaymentHolidayState extends State<EmiWithRepaymentHoliday> {
  TextEditingController principalController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController repaymentPeriodController = TextEditingController();
  TextEditingController repaymentHolidayController = TextEditingController();

  double emi = 0;

  late BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: 'ca-app-pub-1908792034570990/3384093382',
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('Ad loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Ad failed to load: $error');
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );
  }

  @override
  void initState() {
    super.initState();
    _bannerAd = createBannerAd()..load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  void calculateEMI() {
    double principal = double.tryParse(principalController.text) ?? 0;
    double interestRate = double.tryParse(interestRateController.text) ?? 0;
    int repaymentPeriod = int.tryParse(repaymentPeriodController.text) ?? 0;
    int repaymentHoliday = int.tryParse(repaymentHolidayController.text) ?? 0;

    int totalRepaymentPeriod = repaymentPeriod + repaymentHoliday;

    double annualInterestRate = interestRate / 100;

    double quarterlyInterestRate =
        interestRate / 400; // Divide by 400 for quarterly compounding
    double monthlyInterestRate = pow(1 + quarterlyInterestRate, 1 / 3) -
        1; // Convert quarterly interest rate to monthly
    double numerator = principal *
        monthlyInterestRate *
        pow((1 + monthlyInterestRate), totalRepaymentPeriod);
    double denominator =
        pow((1 + monthlyInterestRate), totalRepaymentPeriod) - 1;
    double emiAmount = numerator / denominator;

    // double emiAmount = numerator / denominator;
    // return emiAmount;

// double emi=principal*quarterlyInterestRate*

    setState(() {
      emi = emiAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => calculateEMI(),
              controller: principalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Principal Amount'),
            ),
            TextField(
              onChanged: (value) => calculateEMI(),
              controller: interestRateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Interest Rate (%)'),
            ),
            TextField(
              onChanged: (value) => calculateEMI(),
              controller: repaymentPeriodController,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'Repayment Period (in months)'),
            ),
            TextField(
              onChanged: (value) => calculateEMI(),
              controller: repaymentHolidayController,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'Repayment Holiday (in months)'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Calculate EMI'),
              onPressed: calculateEMI,
            ),
            SizedBox(height: 16),
            Text(
              'EMI: $emi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Spacer(), // Banner Ad widget

            AdWidget(ad: _bannerAd),
          ],
        ),
      ),
    );
  }
}
