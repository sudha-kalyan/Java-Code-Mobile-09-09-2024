import 'package:flutter/material.dart';
import 'package:mobile_ver/base.dart';
import 'package:mobile_ver/PODownload.dart';
import 'package:mobile_ver/homePage.dart';

import 'package:mobile_ver/login.dart';
import 'package:mobile_ver/purchaseOrder.dart';
import 'package:mobile_ver/purchaseOrderpdf.dart';
import 'package:mobile_ver/registration.dart';
import 'package:mobile_ver/main.dart' as main;

import '../SODownload.dart';
import '../SOsoa.dart';
import '../bank.dart';
import '../company.dart';
import '../components/popUpMessage.dart';
import '../customer.dart';
import '../milkType.dart';
import '../purchaseOrderManage.dart';
import '../saleOrder.dart';
import '../saleOrderpdf.dart';
import '../slaeOrderManage.dart';
import '../POsoa.dart';
import '../supplier.dart';
import '../vehicle.dart';


class nvbTop extends StatefulWidget {
  const nvbTop({super.key});

  @override
  State<nvbTop> createState() => _nvbTopState();
}

class _nvbTopState extends State<nvbTop> {
  List<List> nvbList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (main.storage.getItem("loggedIn") == true) {
      setState(() {
        nvbList = [
          ['Home', false, Icons.home, HomePage()],
          ['Purchase Order', false, Icons.local_activity, PurchaseOrderPage()],
          ['Manage PO', false, Icons.local_activity, PurchaseManageOrderPage()],
          ['PO Reports Excel', false, Icons.download, PODownloadPage()],
          ['SO Reports Excel', false, Icons.download, SODownloadPage()],
          ['PDF PO', false, Icons.picture_as_pdf, PurchaseOrderPdfPage()],
          ['PDF SO', false, Icons.picture_as_pdf, SaleOrderPdfPage()],
          ['Sale Order', false, Icons.local_activity, SaleOrderPage()],
         // ['Manage SO', false, Icons.local_activity, SaleManageOrderPage()],
          ['Supplier', false, Icons.local_activity, SupplierPage()],
          ['Vehicle', false, Icons.local_activity, VehiclePage()],
          ['Bank', false, Icons.local_activity, BankPage()],
          ['Milk Type', false, Icons.local_activity, MilkTypePage()],
          ['Company', false, Icons.local_activity, CompanyPage()],
          ['Customer', false, Icons.local_activity, CustomerPage()],
          ['PO SOA', false, Icons.local_activity, SOAPage()],
          ['SO SOA', false, Icons.local_activity, SOSOAPage()],
          ['Logout', false, Icons.logout, HomePage()]
        ];
      });
    } else {
      setState(() {
        nvbList = [
          ['Home', false, Icons.home, HomePage()],
          ['Register', false, Icons.app_registration, RegisterPage()],
          ['Login', false, Icons.login, LoginPage()],
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 288,
          height: double.infinity,
          color: Color.fromARGB(255, 54, 103, 166),
          child: SafeArea(
              top: true,
              child: Column(
                children: <Widget>[
                      const Padding(
                        padding:
                            EdgeInsetsDirectional.only(top: 10, bottom: 20),
                        child: Icon(
                          Icons.image,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ] +
                    nvbList.map<Widget>((e) {
                      return Stack(children: [
                        AnimatedPositioned(
                            duration: const Duration(milliseconds: 100),
                            height: 50,
                            width: e[1] ? 288 : 0,
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: Color.fromARGB(255, 33, 65, 119)),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onHover: (val) {
                              if (val == true) {
                                setState(() {
                                  nvbList[nvbList.indexOf(e)][1] = true;
                                });
                              } else {
                                setState(() {
                                  nvbList[nvbList.indexOf(e)][1] = false;
                                });
                              }
                              ;
                            },
                            onTap: () {
                              if (e[0] == "Logout") {
                                main.storage.setItem("loggedIn", false);
                                main.storage.setItem("loggedPhone", null);
                              }
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BasePage(e[0], e[3])));
                              if (e[0] == "Logout") {
                                main.storage.setItem("loggedIn", false);
                                main.storage.setItem("loggedPhone", null);
                                popUpMsg("Successfully logged out",
                                    Colors.green, context, "Success");
                              }
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  Icon(
                                    e[2],
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  Container(
                                    width: 20,
                                  ),
                                  Text(
                                    e.first,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]);
                    }).toList(),
              )),
        ),
      ),
    );
  }
}
