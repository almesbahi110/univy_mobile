import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univy_mobile/constants/colors.dart';
import 'package:univy_mobile/constants/dimensions.dart';
import 'package:get/get.dart';
import 'package:univy_mobile/providers/user_provider.dart';
import 'package:univy_mobile/services/task_manager/notification_srvices.dart';
import 'package:univy_mobile/services/task_manager/theme_seviese.dart';
import 'package:univy_mobile/ui/pages/profile.dart';
import 'package:univy_mobile/ui/pages/services/serviceMainPage.dart';
import 'package:univy_mobile/ui/pages/task_manager/home_page_task_manager.dart';

int _selectedIndex = 0;

class HomePage extends StatefulWidget {

   HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
  }


  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      Column(
        children: [HomePageBody()],
      ),
      Profile(context: context,)

    ];
    print("height is  " + MediaQuery.of(context).size.height.toString());
    print("width is  " + MediaQuery.of(context).size.width.toString());
    void _ontaped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        //backgroundColor: Colors.white,
        backgroundColor: context.theme.backgroundColor,
        appBar: AppBar(

          leading: GestureDetector(
            onTap: () {
              ThemeService().switchTheme();
              notifyHelper.displayNotification(
                  title: "تم تغيير الثيم بنجاح",
                  body: Get.isDarkMode
                      ? "تم تفعيل الفاتح"
                      : "تم تفعيل الوضع الداكن");
              // notifyHelper.scheduledNotification();
            },
            child: Icon(
              Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
              size: 20,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          backgroundColor: context.theme.backgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png",
                  width: Dimensions.imgWidth40),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(

          type: BottomNavigationBarType.fixed,
          selectedFontSize: Dimensions.font10,
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(color: AppColor.lightBlue),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          backgroundColor: AppColor.mainColor,
          onTap: _ontaped,
          items: [
            // BottomNavigationBarItem(
            //     icon: Icon(
            //       Icons.chat,
            //     ),
            //     label: "مراسلة"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "الرئيسية"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "أنا"),
          ],
        ),
        body: _screens[_selectedIndex],
      ),
    );
  }
}

class Item {
  int? id;
  String title;
  String img;

  Item({required this.title, required this.img, this.id});
}

class HomePageBody extends StatefulWidget {

  const HomePageBody({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserProvider>(context) .user;

    Item item1 = new Item(
        id: 1, title: "خدمات إلكترونية", img: "assets/images/service.png");
    Item item2 = new Item(
        id: 2, title: "علامات الفصل", img: "assets/images/analysis.png");
    Item item3 = new Item(
        id: 3, title: "إدارة المهام", img: "assets/images/prioritize.png");
    List<Item> MyList = [item1, item2, item3];
    return Flexible(
      child: GridView.count(
          padding: EdgeInsets.only(right: 50, left: 50, top: 30),
          childAspectRatio: 2,
          crossAxisCount: 1,
          // crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: MyList.map((data) {
            return InkWell(
              onTap: () {
                if (data.id == 1) {
                  Get.to(ServiceMainPage(user: user, ),
                      transition: Transition.cupertino,
                      duration: Duration(milliseconds: 900));
                } else if (data.id == 2) {
                 // Get.to(page);
                } else if (data.id == 3) {
                  Get.to(HomePageTask());
                } else {

                }
              },
              child: Container(
                // padding: EdgeInsets.only(bottom: Dimensions.height0),
                //margin: EdgeInsets.only(right: 50,left: 50,),
                decoration: BoxDecoration(
                   color: AppColor.darkWhite,
                   // color: context.theme.backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColor.lightBlue,
                      width: Dimensions.width2,
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      data.img,
                      width: 70,
                    ),
                    Text(
                      data.title,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Lemonada",
                        color: Color(0xff263E49),
                        fontSize: Dimensions.font15,
                      ),
                    ),
                    //SizedBox(height: Dimensions.width5,),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}
