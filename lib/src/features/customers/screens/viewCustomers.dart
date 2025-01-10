import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';


import '../../../common _widgets/appBar.dart';
import '../../authentication/controllers/login_controller.dart';
import '../controllers/customer_list_controller.dart';
import '../models/customer.dart';

class ViewCustomer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ViewCustomer();
  }
}

class _ViewCustomer extends State<ViewCustomer> {
  final loginController = Get.put(LoginController());

  final customerListController = Get.put(CustomerListController());

  final searchController = TextEditingController();

  late List<Customer> postsFuture = customerListController.customersList;

  List<Customer>? customers;

  void _latestFormat() {
    final text = searchController.text;
setState(() {
  customers=postsFuture.where((c){
    return c.name!.toLowerCase().contains(text.toLowerCase());
  }).toList();
});


  }


  @override
  void initState() {
    // TODO: implement initState

    customerListController.getCustomers();


    searchController.addListener(_latestFormat);
    customers = postsFuture;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          NAppBar(showBackArrow: true,),
          const SizedBox(
            height: 10,
          ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: MediaQuery.sizeOf(context).width-20,
            padding: const EdgeInsets.all(1),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child:  TextField(

              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search Customers',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.black)),
              ),
            ),
          ),
        ),

          Obx(
            () => SizedBox(
              height: MediaQuery.sizeOf(context).height-200,
              child: Center(
                // FutureBuilder
                child: postsFuture.isNotEmpty
                    ? buildPosts(customers!)
                    : const  SpinKitRotatingCircle(
                  color: Colors.blue,
                  size: 50.0,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  // function to display fetched data on screen
  Widget buildPosts(List<Customer> posts) {

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Container(
          color: Colors.grey.shade300,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 100,
          width: double.maxFinite,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(flex: 3, child: Text(post.name!)),
            ],
          ),
        );
      },
    );
  }
}


