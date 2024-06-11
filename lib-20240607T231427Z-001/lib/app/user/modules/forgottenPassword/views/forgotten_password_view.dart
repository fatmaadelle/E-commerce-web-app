import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../../components/default_button.dart';
import '../../../components/default_form_field.dart';
import '../../../components/hover_text_button.dart';
import '../controllers/forgotten_password_controller.dart';


class ForgottenPasswordView extends GetView<ForgottenPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: FaIcon(FontAwesomeIcons.arrowLeft,
            color:Colors.white),
          onPressed: (){
            Get.offNamed(Routes.HOME);
          },
        ),
        title:  Row(
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

      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: Material(
                elevation: 100,
                child: Container(
                  transformAlignment: Alignment.bottomCenter,
                  width: 450,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                  child: Form(
                    key: controller.formkey,
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 450,
                          color: Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/LOGO3.png",
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),

                        Container(
                          height: 80,
                          color: Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: Colors.indigo,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50),
                        Container(
                          child: defaultFormField(
                            onTap: () {},
                            controller: controller.emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Email address mustn't be empty";
                              }
                              return null;
                            },
                            label: "Email address",
                            prefix: Icons.email,
                          ),
                        ),
                        SizedBox(height: 40),
                        defaultButton(
                          function: () {
                            controller.submitForm();
                          },
                          text: "Continue",
                        ),
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            HoverTextButton(
                              textColor: Colors.blue[900]!,
                              onPressed: () {
                                Get.offNamed(Routes.LOGIN);                              },
                              text: "Login Now",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}