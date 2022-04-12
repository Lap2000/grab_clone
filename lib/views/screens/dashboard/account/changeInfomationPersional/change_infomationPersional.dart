import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grab_clone/controllers/acountController/InformationPersional_controller.dart';

import '../../../../widgets/custom_button1.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_textformfield.dart';

class ChangeInfamationPersional extends GetView<InformationController> {
  ChangeInfamationPersional({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Form(
          key: controller.infoFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Hi,',
                      fontsize: 30,
                    ),
                    Obx(
                      () => CustomText(
                        text: controller.userName.value,
                        fontsize: 20,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Obx(
                  () => CustomTextFormField(
                      controller: controller.controllerName,
                      text: 'Your name',
                      hint: controller.name.value,
                      onSave: (value) {
                        controller.name.value = value!;
                      },
                      validator: (value) {
                        return controller.validateNull(value!);
                      }),
                ),
                SizedBox(
                  height: 30,
                ),
                Obx(
                  () => CustomTextFormField(
                      controller: controller.controllerEmail,
                      text: 'Email',
                      enable: false,
                      hint: controller.email.value,
                      onSave: (value) {
                        controller.email.value = value!;
                      },
                      validator: (value) {}),
                ),
                SizedBox(
                  height: 30,
                ),
                Obx(
                  () => CustomTextFormField(
                      controller: controller.controllerPhone,
                      text: 'Phone Number',
                      hint: controller.phone.value,
                      onSave: (value) {
                        controller.phone.value = value!;
                      },
                      validator: (value) {
                        return controller.validatePhone(value!);
                      }),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Gender',
                        fontsize: 20,
                        color: Colors.black,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 35.0),
                          child: Obx(() => DropdownButton(
                                onChanged: (newValue) {
                                  controller.setSelected(newValue);
                                },
                                value: controller.genderSelected.value,
                                items: <String>[
                                  'Male',
                                  'Female'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ))),
                    ],
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: Column(
                      children: <Widget>[
                        CustomText(
                          text: 'Date of birth',
                          fontsize: 20,
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "${controller.dateOfBirth.value.toLocal()}"
                                  .split(' ')[0],
                            ),
                            IconButton(
                              icon: Icon(Icons.calendar_today_rounded),
                              color: Colors.black,
                              onPressed: () => controller.selectDate(context),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black38,
                        ),
                      ],
                    ),
                    //child: Text("Selected Date: $selectedDate"),
                  ),
                ),
                Obx(
                  () => controller.isLoading.value == true
                      ? const Center(child: CircularProgressIndicator())
                      : const Text(""),
                ),
                CustomButton(
                  onPress: () {
                    controller.doChangeInfo();
                  },
                  text: 'Save',
                  color: Colors.orangeAccent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
