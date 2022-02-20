import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:qsapps_startup/main.dart';
import 'package:qsapps_startup/model/facebook_detail_model.dart';

class HomeScreen extends StatefulWidget {
  final FacebookDetailModel facebookDetailModel;
  const HomeScreen({Key? key, required this.facebookDetailModel})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<String> _kIds = <String>{'product1', 'product2'};
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ProductDetailsResponse>(
          future: InAppPurchase.instance.queryProductDetails(_kIds),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data?.notFoundIDs.isNotEmpty ?? false) {
                // Handle the error.
                return Center(
                  child: Text('No Product Found'),
                );
              } else {
                List<ProductDetails> products = snapshot.data!.productDetails;
                return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          final ProductDetails productDetails = products[
                              index]; // Saved earlier from queryProductDetails().
                          final PurchaseParam purchaseParam =
                              PurchaseParam(productDetails: productDetails);
                          await InAppPurchase.instance
                              .buyConsumable(purchaseParam: purchaseParam);
                        },
                        title: Text(products[index].title),
                        subtitle: Text(products[index].currencySymbol +
                            products[index].price),
                      );
                    });
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountEmail: Text(widget.facebookDetailModel.email),
              accountName: Text(widget.facebookDetailModel.name),
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                    NetworkImage(widget.facebookDetailModel.picture.data.url),
              ),
            ),
            ListTile(
              title: Text('LOGOUT'),
              onTap: () async {
                await FacebookAuth.i.logOut();
                Get.offAll(MyHomePage(title: 'Flutter Demo'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
