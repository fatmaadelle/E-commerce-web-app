import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import '../../../components/default_button.dart';
import '../../../components/default_form_field.dart';
import '../../../components/default_form_field_with_dropdown.dart';
import '../../../components/hover_text_button.dart';
import '../controllers/register_controllers.dart';

class RegisterView extends GetView<RegisterController> {
  @override

  final ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(false);
  void _showLocationPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Location'),
          content: Container(
            height: MediaQuery.sizeOf(context).height*0.75,
            width: MediaQuery.sizeOf(context).width,
            child: FlutterLocationPicker(
              initZoom: 11,
              minZoomLevel: 5,
              maxZoomLevel: 16,
              trackMyPosition: true,
              searchBarBackgroundColor: Colors.white,
              selectedLocationButtonTextstyle: const TextStyle(fontSize: 18),
              mapLanguage: 'en',
              onError: (e) => print(e),
              selectLocationButtonLeadingIcon: const Icon(Icons.check),
              onPicked: (pickedData) {
                // Update controller's address field
                controller.addressController.text = pickedData.address;

                Navigator.of(context).pop(); // Close the dialog
              },
              onChanged: (pickedData) {
                // Update controller's address field on change if needed
              },
              showContributorBadgeForOSM: true,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
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
            padding: const EdgeInsets.only(top: 10.0),
            child: Center(
              child: Material(
                elevation: 100,
                child: Container(
                  width: 800,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                  child: Form(
                    key: controller.formkey1,
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 800,
                          color: Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(

                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Image.asset(
                                  "assets/images/LOGO3.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 15,),

                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: defaultFormField(
                                label: 'First Name',
                                prefix:FontAwesomeIcons.user,
                                prefixColor: Colors.blue,
                                type: TextInputType.name,
                                inputFormatter: FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]+')), // Accept only letters
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your first name';
                                  }
                                  return null;
                                },
                                controller: controller.firstNameController,
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: defaultFormField(
                                label: 'Last Name',
                                prefix:FontAwesomeIcons.user,
                                prefixColor: Colors.red,
                                type: TextInputType.name,
                                inputFormatter: FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]+')), // Accept only letters
                                validate: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  return null;
                                },
                                controller: controller.lastNameController,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        defaultFormField(
                          label: 'Phone Number',
                          prefix:FontAwesomeIcons.phone,
                          prefixColor: Colors.green,
                          type: TextInputType.phone,
                          inputFormatter:FilteringTextInputFormatter.digitsOnly, // Accept only digits
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (value.length != 11) {
                              return 'Phone number must be 11 digits';
                            }
                            return null;
                          },
                          controller: controller.phoneController,),

                        SizedBox(height: 15),
                        defaultFormField(
                          readOnly: true,
                          controller: controller.birthdayController,
                          type: TextInputType.datetime,
                          inputFormatter:
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9/-]')),
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.parse("1940-01-01"),
                              lastDate: DateTime.now(),
                              builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData(
                                  textTheme: TextTheme(
                                    headline1: TextStyle(fontSize: 20,), // Change the font size here
                                  ),
                                ),
                                child: child!,
                              );
                            },

                            ).then((value) {
                              if (value != null) {
                                final formattedDate = DateFormat('yyyy-MM-dd').format(value).toString();
                                print(formattedDate);
                                controller.birthdayController.text = formattedDate;
                              }
                            });
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your Birthday";
                            }
                            return null;
                          },
                          label: "Birthday",
                          prefix:FontAwesomeIcons.calendarAlt,
                          prefixColor: Colors.blue,),
                        SizedBox(height: 15),
                        Container(
                          child: defaultFormFieldWithDropdown(
                            onTap: () {},
                            label: "Select your Gender",
                            items: controller.genders,
                            hint: "Gender",
                            value: controller.selectedGender,
                            onChanged: (String? value) {
                              controller.selectedGender = value;
                            },
                            validate: (String? value) {
                              if (value == null) {
                                return "Gender is required";
                              }
                              return null;
                            },
                            prefix:FontAwesomeIcons.person,
                          ),
                        ),
                        SizedBox(height: 15),
                        defaultFormField(
                          label: 'Home Address',
                          prefix:FontAwesomeIcons.locationDot,
                          prefixColor: Colors.red,
                          type: TextInputType.streetAddress,
                          onTap:(){
                            _showLocationPicker(context);
                          } ,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your home address';
                            }
                            return null;
                          },
                          controller: controller.addressController,
                        ),
                        SizedBox(height: 15),
                        Container(
                          child: defaultFormField(
                            onTap: () {},
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
                            label: "Enter your Email address",
                            prefix:FontAwesomeIcons.envelope,
                            prefixColor: Colors.red,
                          ),
                        ),
                        SizedBox(height: 15),
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
                                label: "Enter your password ",
                                prefix:FontAwesomeIcons.lock,
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
                        SizedBox(height: 15),
                        Container(
                          child: defaultFormField(
                            onTap: () {},
                            controller: controller.rePasswordController,
                            type: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Please Rewrite password ";
                              }
                              if (value != controller.passwordController.text) {
                                return "Passwords don't match";
                              }
                              return null;
                            },
                            label: "Rewrite your password ",
                            prefix:FontAwesomeIcons.lock,
                            prefixColor: Colors.black,
                            isPassword: true,
                          ),
                        ),
                        SizedBox(height: 15),
                        defaultButton(
                          function: controller.registerUser,
                          text: "Register",
                        ),
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                 fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            HoverTextButton(
                              textColor: Colors.blue,
                              onPressed: () {
                                Get.offAllNamed(Routes.LOGIN);
                              },
                              text: "Login",
                            ),
                          ],
                        )
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