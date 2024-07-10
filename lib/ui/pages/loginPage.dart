import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:univy_mobile/constants/colors.dart';
import 'package:univy_mobile/constants/dimensions.dart';
import 'package:univy_mobile/models/Foundation.dart';
import 'package:univy_mobile/providers/auth_service.dart';
import 'package:univy_mobile/ui/pages/homePage.dart';
import 'package:univy_mobile/ui/widgets/bigText.dart';

import '../../models/Api_Response.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  var selectFoundation;

    List<Foundation> dataFoundation = [];

  AuthServices get fundService => GetIt.I<AuthServices>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ApiResponse<List<Foundation>>? _apiResponseFunction;
  bool valdiate = true;
  String? selectetTypePerson;
  bool _isLoading = false;

  _fetchFoundation() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponseFunction = await fundService.getAllFoundation();
    dataFoundation = _apiResponseFunction!.data!;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchFoundation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("height is  " + MediaQuery.of(context).size.height.toString());
    print("width is  " + MediaQuery.of(context).size.width.toString());
    return Builder(builder: (_) {
      if (_isLoading) {
        return Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        ));
      }
      if (_apiResponseFunction!.error == true) {
        return Center(
            child: Text("${_apiResponseFunction!.errorMessage.toString()}"));
      }

      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColor.mainColor,
          body: Container(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Dimensions.height50),
                    //logo
                    Center(
                      child: FadeInUp(
                        delay: Duration(milliseconds: 1000),
                        duration: Duration(milliseconds: 1000),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/logo.png",
                              width: Dimensions.imgWidth40,
                            ),
                            Text("جامعتي",
                                style: TextStyle(
                                  fontSize: Dimensions.font20,
                                  color: Colors.white,
                                  fontFamily: "Kufam",
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: Dimensions.height20),
                    // login container
                    FadeInUp(
                      delay: Duration(milliseconds: 3500),
                      duration: Duration(milliseconds: 1000),
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        height: Dimensions.height470,
                        decoration: BoxDecoration(
                            color: AppColor.darkWhite,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(Dimensions.radius20),
                                bottomRight:
                                    Radius.circular(Dimensions.radius20),
                                bottomLeft:
                                    Radius.circular(Dimensions.radius70))),
                        child: Column(
                          children: [
                            SizedBox(height: Dimensions.height10),
                            //login image
                            FadeIn(
                              delay: Duration(milliseconds: 4000),
                              duration: Duration(milliseconds: 500),
                              child: Center(
                                child: Image.asset(
                                  "assets/images/login.png",
                                  width: Dimensions.width40,
                                ),
                              ),
                            ),
                            //login text
                            FadeInUp(
                                delay: Duration(milliseconds: 4100),
                                duration: Duration(milliseconds: 700),
                                child: BigText(
                                  text: "تسجيل الدخول",
                                  color: AppColor.mainColor,
                                  size: Dimensions.font10,
                                )),
                            //university DropList
                            FadeInUp(
                              delay: Duration(milliseconds: 4600),
                              duration: Duration(milliseconds: 1000),
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: Dimensions.radius20,
                                    right: Dimensions.radius20,
                                    top: Dimensions.radius18),
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: AppColor.lightBlue),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 5.0,
                                          offset: Offset(0, 5)),
                                    ]),
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.school,
                                        color: AppColor.lightBlue,
                                        textDirection: TextDirection.rtl,
                                      ),
                                      hintText: "الدخول ك ",
                                      hintStyle: TextStyle(
                                          fontSize: Dimensions.font12,
                                          color: Colors.grey[600]),
                                      filled: true,
                                      alignLabelWithHint: true,
                                      hintTextDirection: TextDirection.rtl,
                                      border: InputBorder.none),
                                  validator: (value) => value == null
                                      ? 'يرجى تحديد الجامعة'
                                      : null,
                                  value: selectFoundation,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  hint: Text("الجامعة"),
                                  items: dataFoundation.map((menuUnits) {
                                    return DropdownMenuItem(
                                      onTap: () {},
                                      value: menuUnits,
                                      child: Text(menuUnits.foundationName!),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      selectFoundation = val;
                                      ;
                                    });
                                  },
                                ),
                              ),
                            ),

                            //enterAS DropList
                            FadeInUp(
                              delay: Duration(milliseconds: 4600),
                              duration: Duration(milliseconds: 500),
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: Dimensions.radius20,
                                    right: Dimensions.radius20,
                                    top: Dimensions.radius15),
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: AppColor.lightBlue),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 5.0,
                                          offset: Offset(0, 5)),
                                    ]),
                                child:

                                    // TextFormField(
                                    //   cursorColor: AppColor.lightBlue,
                                    //   textDirection: TextDirection.rtl,
                                    //   style: TextStyle(fontSize: Dimensions.font12,color:AppColor.mainColor),
                                    //
                                    // )

                                    DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.person,
                                        color: AppColor.lightBlue,
                                        textDirection: TextDirection.rtl,
                                      ),
                                      hintText: "الدخول ك ",
                                      hintStyle: TextStyle(
                                          fontSize: Dimensions.font12,
                                          color: Colors.grey[600]),
                                      filled: true,
                                      alignLabelWithHint: true,
                                      hintTextDirection: TextDirection.rtl,
                                      border: InputBorder.none),
                                  validator: (value) => value == null
                                      ? 'يرجى تحديد نوع الدخول'
                                      : null,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  hint: selectetTypePerson == null
                                      ? Text("الدخول ك")
                                      : Text(selectetTypePerson!),
                                  items: ["طالب", "محاضر"]
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      selectetTypePerson = val!;
                                    });
                                  },
                                  value: selectetTypePerson,
                                ),
                              ),
                            ),
                            //phone textField
                            FadeInUp(
                              delay: Duration(milliseconds: 4800),
                              duration: Duration(milliseconds: 500),
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: Dimensions.radius20,
                                    right: Dimensions.radius20,
                                    top: Dimensions.radius15),
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: valdiate == true
                                            ? AppColor.lightBlue
                                            : Colors.red),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 5.0,
                                          offset: Offset(0, 5)),
                                    ]),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      setState(() {
                                        valdiate = false;
                                      });
                                    } else {
                                      setState(() {
                                        valdiate = true;
                                      });
                                    }
                                    return null;
                                  },
                                  controller: userNameController,
                                  cursorColor: AppColor.lightBlue,
                                  textDirection: TextDirection.rtl,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      fontSize: Dimensions.font12,
                                      color: AppColor.mainColor),
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.phone,
                                        color: AppColor.lightBlue,
                                        textDirection: TextDirection.rtl,
                                      ),
                                      hintText: selectetTypePerson == "محاضر"
                                          ? "الرقم الوظيفي"
                                          : "الرقم الاكاديمي",
                                      hintStyle: TextStyle(
                                          fontSize: Dimensions.font12,
                                          color: Colors.grey[600]),
                                      filled: true,
                                      alignLabelWithHint: true,
                                      hintTextDirection: TextDirection.rtl,
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            //password textField
                            FadeInUp(
                              delay: Duration(milliseconds: 5000),
                              duration: Duration(milliseconds: 500),
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: Dimensions.radius20,
                                        right: Dimensions.radius20,
                                        top: Dimensions.radius15),
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: valdiate == true
                                                ? AppColor.lightBlue
                                                : Colors.red),
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 5.0,
                                              offset: Offset(0, 5)),
                                        ]),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          setState(() {
                                            valdiate = false;

                                          });
                                        } else {
                                          setState(() {
                                            valdiate = true;
                                          });
                                        }
                                      },
                                      controller: passwordController,
                                      obscureText: true,
                                      cursorColor: AppColor.lightBlue,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontSize: Dimensions.font12,
                                          color: AppColor.mainColor),
                                      decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.lock,
                                            color: AppColor.lightBlue,
                                            textDirection: TextDirection.rtl,
                                          ),
                                          hintText: "كلمة المرور",
                                          hintStyle: TextStyle(
                                              fontSize: Dimensions.font12,
                                              color: Colors.grey[600]),
                                          filled: true,
                                          alignLabelWithHint: true,
                                          hintTextDirection: TextDirection.rtl,
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Positioned(
                                    top: Dimensions.radius50,
                                    left: Dimensions.radius30,
                                    child: valdiate == false
                                        ? Text(
                                            "كلمة سر خاطئة",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: Dimensions.font8),
                                          )
                                        : Container(),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            // logIn button
                            FadeInUp(
                              delay: Duration(milliseconds: 5200),
                              duration: Duration(milliseconds: 700),
                              child: Container(

                                  margin: EdgeInsets.only(
                                      left: Dimensions.radius20,
                                      right: Dimensions.radius20),
                                  height: Dimensions.height50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius10),
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            AppColor.lightBlue,
                                            AppColor.darkBlue,
                                          ])),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          final result =
                                              await fundService.createAuth(
                                                  context: context,
                                                  username: userNameController
                                                      .text
                                                      .trim(),
                                                  password: passwordController
                                                      .text
                                                      .trim());

                                          if (result.data!.isAuthenticated !=
                                              true) {
                                            Get.snackbar(
                                                backgroundColor:
                                                    Colors.redAccent,
                                                "عذراً",
                                                "${result.data!.message}");
                                          } else {
                                            Get.snackbar(
                                                backgroundColor:
                                                    Colors.greenAccent,
                                                "نجاح",
                                                "تم تسجيل الدخول بنجاح");

// showSnackBar(context, "تم تسجيل الدخول بنجاح ");
                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(builder: (_) {
                                              return HomePage();
                                            }));
                                          }
// final snackbar =SnackBar(content: Text("login success"));
                                        } else {
                                          Get.snackbar(

                                              backgroundColor: Colors.red,
                                              "خطا",
                                              "يرجى كتابة جميع البيانات");
                                        }
                                      },
                                      child: Center(
child: BigText(text: "تسجيل الدخول",
color: Colors.white,
size: Dimensions.font12,),
),)),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
