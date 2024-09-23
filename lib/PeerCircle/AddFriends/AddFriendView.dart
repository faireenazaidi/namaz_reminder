import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Widget/myButton.dart';
import 'AddFriendController.dart';
import 'AddFriendDataModal.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';

class AddFriendView extends GetView<AddFriendController> {
  const AddFriendView({super.key});

  @override
  Widget build(BuildContext context) {
    //final AddFriendController controller = Get.put(AddFriendController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Invite friends', style: MyTextTheme.mediumBCD),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body:
      GetBuilder(
        init: controller,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  // controller: controller.nameC.value,
                  cursorColor: AppColor.circleIndicator,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search Username..",
                    hintStyle: MyTextTheme.mediumCustomGCN,
                    // prefixIcon: Image.asset("asset/profile.png"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:  BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Friend Reuests",style: MyTextTheme.largeBCB,),
                  ],
                ),

                Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.getFriendRequestList.length,
                      itemBuilder: (context, index) {
                        FriendRequestDataModal friendRequestData = controller.getFriendRequestList[index];
                        print("!!!!!!!!!!"+friendRequestData.name.toString());

                        return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 20,
                                child: Icon(Icons.person,color: Colors.white,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0,top: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(friendRequestData.name.toString(),style: MyTextTheme.mediumGCB.copyWith(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold ),),
                                    Text(friendRequestData.mobileNo.toString(),style: MyTextTheme.mediumGCB.copyWith(fontSize: 14,),),

                                  ],
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              print("${friendRequestData.id}");
                              await controller.acceptFriendRequest(friendRequestData.id.toString());
                            },
                            child: Container(
                              height: 30,width: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColor.white),
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.circleIndicator
                              ),
                               child: Center(child: Text("Accept",style: TextStyle(color: Colors.white),)),
                            ),
                          )
                        ],
                      );
                    },)),  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Registered User",style: MyTextTheme.largeBCB,),
                  ],
                ),


                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.getRegisteredUserList.length,
                    itemBuilder: (context, index) {
                      RegisteredUserDataModal registeredData = controller.getRegisteredUserList[index];
                      print("?????????"+registeredData.name.toString());

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 20,
                                child: Icon(Icons.person,color: Colors.white,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0,top: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(registeredData.name.toString(),style: MyTextTheme.mediumGCB.copyWith(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold ),),
                                    Text(registeredData.mobileNo.toString(),style: MyTextTheme.mediumGCB.copyWith(fontSize: 14,),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              await controller.sendFriendRequest(registeredData);
                            },
                            child: Container(
                              height: 30,width: 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.white),
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.circleIndicator
                              ),
                              child: Center(child: Text("Invite",style: TextStyle(color: Colors.white),)),
                            ),
                          )


                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          );
        }
      ),



    );
  }


}