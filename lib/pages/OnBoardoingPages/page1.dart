import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/colors.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

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
              Image.asset('assets/images/onboarding1.png',
                width:(screenWidth*0.7)),
              const SizedBox(height: 20),
              Text(
                "Achieve Goals",
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
                  "Unlock Your Academic Potential Without Financial Barriers",
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
