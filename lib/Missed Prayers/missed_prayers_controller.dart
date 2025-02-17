import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Leaderboard/LeaderBoardController.dart';
import '../Leaderboard/leaderboardDataModal.dart';

class MissedPrayersController extends GetxController {
  RxString formattedDate = "".obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Get.lazyPut(() => LeaderBoardController());
    Get.find<LeaderBoardController>().leaderboard(getFormattedDate());
  }

  @override
  void dispose() {
    Get.delete<LeaderBoardController>();
    super.dispose();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    Get.delete<LeaderBoardController>();
    Get.delete<DateController>();
    super.onClose();
  }

  String getFormattedDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    return formattedDate;
  }
}