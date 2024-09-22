import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddApplicantScreen extends StatefulWidget {
  const AddApplicantScreen({super.key});

  @override
  _AddApplicantScreenState createState() => _AddApplicantScreenState();
}

class _AddApplicantScreenState extends State<AddApplicantScreen> {
  // List of product options with selection status
  final List<Map<String, dynamic>> products = [
    {'title': 'DBS - Basic Check', 'price': '12£', 'isSelected': false},
    {'title': 'DBS - Standard Check', 'price': '12£', 'isSelected': false},
    {'title': 'DBS - Enhanced Check', 'price': '12£', 'isSelected': false},
    {'title': 'Reference Check', 'price': '12£', 'isSelected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const Text(
                    'Applicant Details',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // First Name
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'First Name *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Last Name
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Last Name *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Job Role (Dropdown)
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Job Role',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
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
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 16),

                  // Email Address
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email Address *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Phone Number
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            const SizedBox(width: 20),

            // Right Section: Products (Scrollable with Selection)
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
                        childAspectRatio: 1.2,
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
                            product['title'],
                            product['price'],
                            product['isSelected'],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductCard(String title, String price, bool isSelected) {
    return Stack(
      children: [
        Container(
          height: 150,
          width: 300,
          decoration: BoxDecoration(
              color: isSelected ? Colors.blue[50] : Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: isSelected ? Colors.blue.shade700 : Colors.grey.shade300,
                width: isSelected ? 2.0 : 1.0,
              )),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24), // Space for the icon
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.blue.shade700 : Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Price: $price',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -10, // Adjust this value to position the icon on the border
          left: -10, // Adjust this value as per your requirement
          child: CircleAvatar(
            backgroundColor: isSelected ? Colors.blue.shade700 : Colors.grey,
            radius: 14,
            child: Icon(
              isSelected ? Icons.abc : Icons.check_circle,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
