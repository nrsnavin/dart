import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../../common _widgets/appBar.dart';
import '../controllers/new_rawMaterial_form_controller.dart';
import '../models/material.dart';

class RawMaterialViewScreen extends StatefulWidget {
  @override
  State<RawMaterialViewScreen> createState() => _RawMaterialViewScreen();
}

class _RawMaterialViewScreen extends State<RawMaterialViewScreen> {
  int currentPageIndex = 0;
  final materialsController = Get.put(RawMaterialCreationController());

  late List<MaterialModel> weftsData = materialsController.weftsMaterial;
  late List<MaterialModel> warpsData = materialsController.warpsMaterials;
  late List<MaterialModel> rubbersData = materialsController.rubbersMaterial;
  late List<MaterialModel> coveringsData =
      materialsController.coveringsMaterial;

  @override
  void initState() {
    materialsController.getCoverings();
    materialsController.getRubbers();
    materialsController.getWarps();
    materialsController.getWefts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: NAppBar(showBackArrow: true,),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.add_card_sharp),
            icon: Icon(Icons.plumbing_sharp),
            label: 'Warp Yarn',
          ),
          NavigationDestination(
            icon: Icon(Icons.add),
            label: 'Rubber',
          ),
          NavigationDestination(
            label: 'Weft Yarn',
            icon: Icon(Icons.yard),
          ),
          NavigationDestination(
            icon: Icon(Icons.ice_skating_rounded),
            label: 'Covering',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text("Warp Yarns ",style:TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Obx(
                  () => SizedBox(
                    height: MediaQuery.sizeOf(context).height-250,
                    child: Center(
                      // FutureBuilder
                      child: warpsData.isNotEmpty
                          ? buildPosts(warpsData)
                          : const Text("Loading"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        /// Notifications page
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("Rubbers ",style:TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Obx(
                  () => SizedBox(
                    height: MediaQuery.sizeOf(context).height-250,
                    child: Center(
                      // FutureBuilder
                      child: rubbersData.isNotEmpty
                          ? buildPosts(rubbersData)
                          : const Text("Loading"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        /// Messages page
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("Weft Yarns ",style:TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Obx(
                  () => SizedBox(
                    height: MediaQuery.sizeOf(context).height-250,
                    child: Center(
                      // FutureBuilder
                      child: weftsData.isNotEmpty
                          ? buildPosts(weftsData)
                          : const Text("Loading"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("Covering Yarns ",style:TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Obx(
                  () => SizedBox(
                    height: MediaQuery.sizeOf(context).height-250,
                    child: Center(
                      // FutureBuilder
                      child: coveringsData.isNotEmpty
                          ? buildPosts(coveringsData)
                          : const Text("Loading"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ][currentPageIndex],
    );
  }

  Widget buildPosts(List<MaterialModel> p) {
    return ListView.builder(
      itemCount: p.length,
      itemBuilder: (context, index) {
        final order = p[index];
        return InkWell(
          onDoubleTap: () => {
            // Get.to(() => ViewWastageOnDateScreen(), arguments: [order.date])
          },
          child: Container(
            color: order.stock<order.minStock?Colors.redAccent:Colors.white70,
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            width: double.maxFinite,
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Text(
                      "Name-",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 16),
                    ),
                    Text(
                      order.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Text(
                      "Stock:",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                    Text(
                      order.stock.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Text(
                      "Min Stock:",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                    Text(
                      order.minStock.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    const Text(
                      "Supplier:",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: 18),
                    ),
                    Text(
                      order.supplier.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
