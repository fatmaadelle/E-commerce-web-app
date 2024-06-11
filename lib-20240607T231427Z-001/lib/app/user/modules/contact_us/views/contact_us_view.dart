import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../../components/app_bar.dart';
import '../../../components/default_form_field.dart';
import '../../../components/drawer.dart';
import '../../../components/footer.dart';
import '../../../components/screen_title.dart';
import '../controllers/contact_us_controller.dart';

class ContactUsView extends StatelessWidget {
  final ContactUsController _controller = Get.put(ContactUsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
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
      drawer: DefaultDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ScreenTitle(title: "Contact Us",
                dividerEndIndent: MediaQuery.sizeOf(context).width*  0.10,),
              ),
              Container(
                color: cb,
                child: Form(
                  key: _controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 2,
                            color: Colors.blue[600]!,
                          ),
                        ),
                        child: defaultFormField(
                          prefixColor: Colors.blue[900]!,
                          controller: _controller.nameController,
                          label: 'Name',
                          validate: _controller.validateName,
                          type: TextInputType.text,
                          prefix: CupertinoIcons.person,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 2,
                            color: Colors.blue[600]!,
                          ),
                        ),
                        child: defaultFormField(
                          controller: _controller.emailController,
                          type: TextInputType.emailAddress,
                          validate: _controller.validateEmail,
                          label: "E-mail",
                          prefix: Icons.email_outlined,
                          prefixColor: Colors.blue[900]!,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 2,
                            color: Colors.blue[600]!,
                          ),
                        ),
                        child: TextFormField(
                          controller: _controller.messageController,
                          decoration: InputDecoration(
                            labelText: 'Message',
                            enabled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: Icon(
                              Icons.message,
                              color: Colors.blue[900],
                            ),
                          ),
                          maxLines: 4,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your message';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: _controller.submitMessage,
                          child: Text('Submit'),
                        ),
                      ),
                      SizedBox(height: 420),
                      FooterSection(),
                    ],
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
