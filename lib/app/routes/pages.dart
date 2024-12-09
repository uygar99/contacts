import 'package:contacts/app/routes/routes.dart';
import 'package:get/get.dart';

import '../services/user_service.dart';
import '../views/contacts/contacts_controller.dart';
import '../views/contacts/contacts_view.dart';

List<GetPage> pages = [
  GetPage(
    name: Routes.contacts,
    page: () => const ContactsView(),
    binding: BindingsBuilder(() {
      Get.put<ContactsController>(ContactsController());
      Get.lazyPut<UserService>(() => UserService());
    }),
  ),
];
