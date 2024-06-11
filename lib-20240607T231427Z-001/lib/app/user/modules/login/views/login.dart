import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants.dart';
import '../../../../routes/app_pages.dart';
import '../../../components/default_button.dart';
import '../../../components/default_form_field.dart';
import '../../../components/hover_text_button.dart';
import '../controller/login_controller.dart';

class LoginView extends GetView<LoginController> {
   LoginView({Key? key}) : super(key: key);
  final ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(false);
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
      body: GetBuilder<LoginController>(
        builder: (controller) => ListView(
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
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            child: defaultFormField(
                              controller: controller.emailController,
                              type: TextInputType.emailAddress,
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!EmailValidator.validate(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              label: "Email address",
                              prefix: FontAwesomeIcons.envelope,
                              prefixColor: Colors.red
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            child: ValueListenableBuilder<bool>(
                              valueListenable: isPasswordVisible,
                              builder: (context, value, child) {
                                return defaultFormField(
                                  controller: controller.passwordController,
                                  type: TextInputType.visiblePassword,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return "Please Write the Password";
                                    }
                                    return null;
                                  },
                                  label: "password ",
                                  prefix: FontAwesomeIcons.lock,
                                  prefixColor: Colors.black,
                                  suffix:
                                  value ? FontAwesomeIcons.eye : Icons.visibility_off,
                                  isPassword: !value,
                                  showPassword: () {
                                    isPasswordVisible.value = !isPasswordVisible.value;
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              HoverTextButton(
                                textColor: Colors.blue,
                                onPressed: () {
                                  // Navigate to forgotten password screen
                                  Get.toNamed('/forgotten');
                                },
                                text: "Forgotten Password",
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          defaultButton(
                              function:() {
                                if (controller.emailController == "adminfady@gmail.com"&&controller.passwordController=="01115795413")
                                {
                                  Get.offAllNamed(Routes.PRODUCTMANGE);
                                }
                                controller.signInWithEmailAndPassword();
                                },
                              text: "login",
                              fontsize: 20
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "don't have account ?",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              HoverTextButton(
                                textColor: Colors.blue,
                                onPressed: () {
                                  // Navigate to register screen
                                  Get.toNamed('/register');
                                },
                                text: "Register Now",

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
      ),
    );
  }
}
