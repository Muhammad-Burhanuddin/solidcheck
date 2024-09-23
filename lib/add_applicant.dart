import 'package:flutter/material.dart';

import 'widgets/customtextfield.dart';

class AddApplicantScreen extends StatefulWidget {
  const AddApplicantScreen({super.key});

  @override
  _AddApplicantScreenState createState() => _AddApplicantScreenState();
}

class _AddApplicantScreenState extends State<AddApplicantScreen> {
  String? selectedRole;

  // List of product options with selection status and price
  final List<Map<String, dynamic>> products = [
    {
      'image': 'assets/dbs.png',
      'title': 'DBS - Basic Check',
      'price': 12.0,
      'isSelected': false
    },
    {
      'image': 'assets/dbs.png',
      'title': 'DBS - Standard Check',
      'price': 32.0,
      'isSelected': false
    },
    {
      'image': 'assets/dbs.png',
      'title': 'DBS - Enhanced Check',
      'price': 50.0,
      'isSelected': false
    },
    {
      'image': 'assets/referencecheck.png',
      'title': 'Reference Check',
      'price': 20.0,
      'isSelected': false
    },
    {
      'image': 'assets/dbs.png',
      'title': 'DBS - Basic Check',
      'price': 12.0,
      'isSelected': false
    },
    {
      'image': 'assets/dbs.png',
      'title': 'DBS - Standard Check',
      'price': 32.0,
      'isSelected': false
    },
    {
      'image': 'assets/dbs.png',
      'title': 'DBS - Enhanced Check',
      'price': 50.0,
      'isSelected': false
    },
    {
      'image': 'assets/referencecheck.png',
      'title': 'Reference Check',
      'price': 20.0,
      'isSelected': false
    },
  ];

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Calculate total price
  double getTotalPrice() {
    double total = 0.0;
    for (var product in products) {
      if (product['isSelected']) {
        total += product['price'];
      }
    }
    return total;
  }

  // Get list of selected products
  List<Map<String, dynamic>> getSelectedProducts() {
    return products.where((product) => product['isSelected']).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Applicant Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Section: Applicant Details Form
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 18,
                          color: Color(0xFF004276),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Applicant Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF004276),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF9F9),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'First Name: *',
                            style: TextStyle(
                                color: Color(0xFF282828),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: firstNameController,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Last Name: *',
                            style: TextStyle(
                                color: Color(0xFF282828),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: lastNameController,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Job Role: *',
                            style: TextStyle(
                                color: Color(0xFF282828),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),
                          CustomDropdown(
                            labelText: 'Job Role',
                            value: selectedRole,
                            items: const [
                              DropdownMenuItem(
                                value: 'Role 1',
                                child: Text('Role 1'),
                              ),
                              DropdownMenuItem(
                                value: 'Role 2',
                                child: Text('Role 2'),
                              ),
                              DropdownMenuItem(
                                value: 'Role 3',
                                child: Text('Role 3'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedRole = value;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Email: *',
                            style: TextStyle(
                                color: Color(0xFF282828),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: emailController,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Phone: *',
                            style: TextStyle(
                                color: Color(0xFF282828),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: phoneController,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 20),

            // Right Section: Products (with Selection and Total)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Products',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Scrollable Products Grid
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 4,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              product['isSelected'] = !product['isSelected'];
                            });
                          },
                          child: buildProductCard(
                            product['image'],
                            product['title'],
                            product['price'],
                            product['isSelected'],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Display Selected Items and Total
                  const Text(
                    'Selected Items:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: getSelectedProducts().map((product) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(product['title']),
                            Text('${product['price']}£'),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 10),

                  Divider(
                    color: Colors.black,
                    thickness: 1.0,
                  ),

                  // Display Total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text('${getTotalPrice()}£',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Buttons: Start Application and Send Form
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Start application logic
                        },
                        child: const Text('Start Application'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Send form to applicant logic
                        },
                        child: const Text('Send form to applicant'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductCard(
      String image, String title, double price, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue[50] : const Color(0xFFF1F9FF),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: isSelected ? const Color(0xFF004276) : Colors.transparent,
          width: isSelected ? 2.0 : 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Container(
            height: 300,
            child: Image.asset(
              image,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF282828),
            ),
          ),
          subtitle: Text(
            'Price: $price',
            style: TextStyle(color: Color(0XFF5485AB)),
          ),
        ),
      ),
    );
  }
}
