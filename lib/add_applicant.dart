import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'widgets/customtextfield.dart';

class AddApplicantScreen extends StatefulWidget {
  const AddApplicantScreen({super.key});

  @override
  _AddApplicantScreenState createState() => _AddApplicantScreenState();
}

class _AddApplicantScreenState extends State<AddApplicantScreen> {
  Future<void> saveApplicantData() async {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final role = selectedRole;

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        role == null) {
      // Show an error dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please fill in all fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Create a map to store the applicant's data
    final applicantData = {
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'email': email,
      'job_role': role,
      'selected_products': getSelectedProducts(),
      'total_price': getTotalPrice(),
    };

    // Save to Firestore
    await FirebaseFirestore.instance
        .collection('applicants')
        .add(applicantData);
  }

  String? selectedRole;

  // List of product options with selection status and price
  final List<Map<String, dynamic>> products = [
    {
      'image': 'assets/dbs.png',
      'title': 'DBS - Basic Check',
      'subtitle': 'DBS',
      'price': 12.0,
      'isSelected': false
    },
    {
      'image': 'assets/dbs.png',
      'title': 'DBS - Standard Check',
      'subtitle': 'DBS',
      'price': 32.0,
      'isSelected': false
    },
    {
      'image': 'assets/dbs.png',
      'title': 'DBS - Enhanced Check',
      'subtitle': 'DBS',
      'price': 50.0,
      'isSelected': false
    },
    {
      'image': 'assets/referencecheck.png',
      'title': 'Reference Check',
      'subtitle': 'RTW',
      'price': 20.0,
      'isSelected': false
    },
    {
      'image': 'assets/dbs.png',
      'title': 'DBS - Basic Check',
      'subtitle': 'DBS',
      'price': 12.0,
      'isSelected': false
    },
    {
      'image': 'assets/dbs.png',
      'title': 'Wrtie to Work Check',
      'subtitle': 'RTW',
      'price': 32.0,
      'isSelected': false
    },
    {
      'image': 'assets/acc.png',
      'title': 'Advertise Crediet Check',
      'subtitle': 'ACC',
      'price': 50.0,
      'isSelected': false
    },
    {
      'image': 'assets/idcheck.png',
      'title': 'ID Check',
      'subtitle': 'ID',
      'price': 12.0,
      'isSelected': false
    },
  ];
  int _selectedIndex = 0;

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
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            Row(
              children: [
                Image.asset(
                  'assets/solid check logo.png', // Your logo image here
                  height: 40,
                ),
                const SizedBox(width: 10),
              ],
            ),
            // Center menu items
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return constraints.maxWidth > 600
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildMenuItem("Dashboard", 0),
                            _buildMenuItem("Results", 1),
                            _buildMenuItem("Download Reports", 2),
                            _buildMenuItem("Job Roles", 3),
                            _buildMenuItem("Reminders", 4),
                            _buildMenuItem("Help", 5),
                          ],
                        )
                      : Wrap(
                          children: [
                            _buildMenuItem("Dashboard", 0),
                            _buildMenuItem("Results", 1),
                            _buildMenuItem("Download Reports", 2),
                            _buildMenuItem("Job Roles", 3),
                            _buildMenuItem("Reminders", 4),
                            _buildMenuItem("Help", 5),
                          ],
                        );
                },
              ),
            ),
            // Profile dropdown on the right
            PopupMenuButton<int>(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  value: 0,
                  enabled: false,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text('JS'),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('John Smith',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('johnsmith@companyname.co.uk',
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem<int>(
                    value: 1, child: Text("Manage Account")),
                const PopupMenuItem<int>(
                    value: 2, child: Text("Company Profile")),
                const PopupMenuItem<int>(value: 3, child: Text("Settings")),
                const PopupMenuItem<int>(
                    value: 4, child: Text("Notifications")),
                const PopupMenuDivider(),
                const PopupMenuItem<int>(
                  value: 5,
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red),
                      SizedBox(width: 10),
                      Text("Log Out", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == 5) {
                  // Handle logout action
                }
              },
              child: const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('JS'),
                  ),
                  SizedBox(width: 10),
                  Text('John Smith', style: TextStyle(color: Colors.black)),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ],
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
                            keyboardtype: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid name'; // Error message
                              }
                              return null; // Return null if the input is valid
                            },
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
                            keyboardtype: TextInputType.name,
                            controller: lastNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid name'; // Error message
                              }
                              return null; // Return null if the input is valid
                            },
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
                            keyboardtype: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid Email'; // Error message
                              }
                              return null; // Return null if the input is valid
                            },
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
                            keyboardtype: TextInputType.number,
                            controller: phoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid Phone'; // Error message
                              }
                              return null; // Return null if the input is valid
                            },
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

                  const Divider(
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
                      Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF004276),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Center(
                          child: Text(
                            'Add Application',
                            style: TextStyle(
                                color: Color(0xFF004276),
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          saveApplicantData();
                        },
                        child: Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF004276),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Center(
                            child: Text(
                              'Send Form to Applicant',
                              style: TextStyle(
                                  color: Color(0xFF004276),
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
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

  Widget _buildMenuItem(String title, int index) {
    return TextButton(
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: _selectedIndex == index
                  ? const Color(0xFF004276)
                  : Colors.black,
              fontSize: 19,
              fontWeight:
                  _selectedIndex == index ? FontWeight.w400 : FontWeight.w400,
            ),
          ),
          _selectedIndex == index
              ? Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  height: 2.0,
                  width: 100.0,
                  color: const Color(0xFF004276),
                )
              : Container(),
        ],
      ),
    );
  }
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
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF282828),
          ),
        ),
        subtitle: Text(
          'Price: $price',
          style: const TextStyle(color: Color(0XFF5485AB)),
        ),
      ),
    ),
  );
}
