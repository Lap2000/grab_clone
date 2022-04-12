//Gesture Build AccountPage
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grab_clone/routes/route.dart';

buildAccountOption(BuildContext context, String title, Icon icon) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        //color: Colors.white,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black87.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.black,
            padding: const EdgeInsets.all(20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            //backgroundColor: const Color(0xFFF5F6F9),
          ),
          onPressed: () {
            Future.delayed(const Duration(milliseconds: 150), () {
              Get.toNamed(AppRoutes.informationPersional);
            });
          },
          child: Row(
            children: [
              icon,
              const SizedBox(width: 20),
              Expanded(
                  child: Text(
                title,
                style: TextStyle(fontSize: 20),
              )),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    ),
  );
}

//Gesture Build HistoryPage
GestureDetector buildHistoryPage(
    BuildContext context, String title, Icon icon) {
  return GestureDetector(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: () {},
        child: Row(
          children: [
            icon,
            const SizedBox(width: 20),
            Expanded(child: Text(title)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    ),
  );
}

//Gesture Build ChangePasswordPage
GestureDetector buildChangePwd(BuildContext context, String title, Icon icon) {
  return GestureDetector(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: () {},
        child: Row(
          children: [
            icon,
            const SizedBox(width: 20),
            Expanded(child: Text(title)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    ),
  );
}

//Gesture Build Logout
GestureDetector buildLogout(BuildContext context, String title, Icon icon) {
  return GestureDetector(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: () {},
        child: Row(
          children: [
            icon,
            const SizedBox(width: 20),
            Expanded(child: Text(title)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    ),
  );
}

//Gesture Build HelpPage
GestureDetector buildHelpPage(BuildContext context, String title, Icon icon) {
  return GestureDetector(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: () {},
        child: Row(
          children: [
            icon,
            const SizedBox(width: 20),
            Expanded(child: Text(title)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    ),
  );
}
