import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../components/footer.dart';
import '../../../components/screen_title.dart';
import '../controllers/about_us_controller.dart';

class AboutUsView extends GetView<AboutUsController> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextButton(
            onPressed: () {
              Get.offNamed(Routes.HOME);
              },
            child:
            FaIcon(FontAwesomeIcons.arrowLeft,
              color: Colors.white,
                size: 16.sp,),
          ),
        ),

        title: Center(
          child: Row(
            children: [
              MaterialButton(
                onPressed: () {
                  Get.offNamed(Routes.HOME);
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/LOGO3.png",
                      width: 100,
                      height: 50,
                    ),
                    Text(
                      'FOM',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 0.035 * MediaQuery.of(context).size.width),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ScreenTitle(title: 'About Us',),
            Container(
              color: cb,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top:20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 24),
                      Container(
                        width: screenWidth ,
                        height: screenHeight>700 ? 80:60,
                        decoration: BoxDecoration(
                            color:cf
                        ),
                        child: Center(
                          child: Text(
                            'Welcome to Our World!',
                            style: TextStyle(
                              fontSize:screenWidth >800? 50:25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Vivid text color
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      AnimatedContainer(
                        duration: Duration(seconds: 2),
                        curve: Curves.bounceInOut,
                        child: Container(
                          width: 600,
                          height: 600,
                          child: Image.asset(
                            'assets/images/LOGO.png',
                            fit: BoxFit.contain ,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        width:screenWidth ,
                        height:screenHeight>850? 120: 70,
                        decoration: BoxDecoration(
                            color:cf
                        ),
                        child: Center(
                          child: Text(
                            'Our Journey',
                            style: TextStyle(
                              fontSize: screenWidth >700 ? 50:25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Lively text color
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(20)
                        ),
                        width:screenWidth >700? screenWidth*0.95 :screenWidth,
                        height: 150,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'From a small startup to a leading e-commerce giant, our journey has been nothing short of extraordinary. We started with a simple mission: to deliver joy and value to every customer, every day.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        decoration: BoxDecoration(
                          color:cf,
                        ),
                        width: screenWidth ,
                        height: screenHeight >850 ? 120:70,
                        child: Center(
                          child: Text(
                            'Our Commitment',
                            style: TextStyle(
                              fontSize:screenWidth >700 ? 50:25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Vivid text color
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(20)
                        ),
                        width:screenWidth >700? screenWidth*0.95 :screenWidth,
                        height:150,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'We are committed to sustainability, diversity, and innovation. Our team is constantly exploring new ways to enhance your shopping experience while caring for our planet and supporting our community.',
                              textAlign:TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      FooterSection(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
