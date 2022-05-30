import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grab_clone/controllers/user_acount_controller/Information_persional_controller.dart';

import '../../../../widgets/custom_button1.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_textformfield.dart';

class ChangeInfamationPersional extends GetView<InformationController> {
  ChangeInfamationPersional({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black87,
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Đổi thông tin cá nhân',
          style: TextStyle(fontSize: 20, color: Colors.black87),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Form(
          key: controller.infoFormKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                const SizedBox(
                  height: 20,
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
                const SizedBox(
                  height: 20,
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
                      validator: (value) {
                        return null;
                      }),
                ),
                const SizedBox(
                  height: 20,
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
                const SizedBox(
                  height: 20,
                ),
                Column(
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
                              icon: const Icon(Icons.calendar_today_rounded),
                              color: Colors.black,
                              onPressed: () => controller.selectDate(context),
                            ),
                          ],
                        ),
                        const Divider(
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
