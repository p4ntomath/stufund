import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/colors.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/onboarding3.png',
                width:(screenWidth*0.4)
                ),
              const SizedBox(height: 20),
              Text(
                "Professional Assistance",
                style: GoogleFonts.lato(
                  color: AppColors.text,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Text(
                  "Receive expert guidance when applying for bursaries and scholarships",
                  textAlign: TextAlign.center,
                  style:  GoogleFonts.lato(
                    color: AppColors.text,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
