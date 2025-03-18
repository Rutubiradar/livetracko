import 'package:floating_tabbar/lib.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../util/app_utils.dart';
import '../../widgets/constant.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        backgroundColor: appthemColor,
        title: const Text('Add Item',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        leading: AppUtils.backButton(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // TextFields for business name , mobile , email , gstin, contact person , address
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Item Name*",
                      style: TextStyle(color: Colors.black, fontSize: 14)),
                  5.heightBox,
                  TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Enter Item Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            10.heightBox,
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Sell Price*",
                            style:
                                TextStyle(color: Colors.black, fontSize: 14)),
                        5.heightBox,
                        TextField(
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'HSN/SAC Code',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Unit*",
                            style:
                                TextStyle(color: Colors.black, fontSize: 14)),
                        5.heightBox,
                        //dropdown like  Piece, Kg, Litre
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              underline: SizedBox.shrink(),
                              value: "Pieces",
                              isExpanded: true,
                              items: [
                                DropdownMenuItem(
                                    child: Text("Pieces (PCS)"),
                                    value: "Pieces"),
                                DropdownMenuItem(
                                    child: Text("Kg"), value: "Kg"),
                                DropdownMenuItem(
                                    child: Text("Litre"), value: "Litre"),
                              ],
                              onChanged: (value) {}),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 6),
              child: Row(
                children: [
                  Checkbox(
                      value: false,
                      onChanged: (value) {},
                      activeColor: appthemColor),
                  Text("Price Includes Tax",
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("HSN/SAC Code",
                            style:
                                TextStyle(color: Colors.black, fontSize: 14)),
                        5.heightBox,
                        TextField(
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'HSN/SAC Code',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tax",
                            style:
                                TextStyle(color: Colors.black, fontSize: 14)),
                        5.heightBox,
                        //dropdown like GST
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              underline: SizedBox.shrink(),
                              value: "GST @ 0%",
                              isExpanded: true,
                              items: [
                                DropdownMenuItem(
                                    child: Text("GST @ 0%"), value: "GST @ 0%"),
                                DropdownMenuItem(
                                    child: Text("GST @ 0.25%"),
                                    value: "GST @ 0.25%"),
                                DropdownMenuItem(
                                    child: Text("GST @ 3%"), value: "GST @ 3%"),
                                DropdownMenuItem(
                                    child: Text("GST @ 5%"), value: "GST @ 5%"),
                                DropdownMenuItem(
                                    child: Text("GST @ 12%"),
                                    value: "GST @ 12%"),
                                DropdownMenuItem(
                                    child: Text("GST @ 18%"),
                                    value: "GST @ 18%"),
                                DropdownMenuItem(
                                    child: Text("GST @ 28%"),
                                    value: "GST @ 28%"),
                              ],
                              onChanged: (value) {}),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            10.heightBox,
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("MRP",
                            style:
                                TextStyle(color: Colors.black, fontSize: 14)),
                        5.heightBox,
                        TextField(
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'MRP',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Stock",
                            style:
                                TextStyle(color: Colors.black, fontSize: 14)),
                        5.heightBox,
                        TextField(
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            hintText: 'Stock',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Item Images",
                      style: TextStyle(color: Colors.black, fontSize: 16))),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                        child: Icon(
                      Icons.add_rounded,
                      color: appthemColor,
                      size: 40,
                    )),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                        child: Icon(
                      Icons.add_rounded,
                      color: appthemColor,
                      size: 40,
                    )),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            const SizedBox(height: 5),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: appthemColor,
                    minimumSize: const Size(double.maxFinite, 50)),
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text("Save Outlet",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
