import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:solidcheck/applicantsmodels.dart';
import 'package:solidcheck/firestorservices.dart';
import 'add_applicant.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Keep track of which menu item is selected
  int _selectedIndex = 0;

  final Map<String, String> checkImages = {
    'SMC': 'assets/sms.png',
    'RTW': 'assets/rtwc.png',
    'DBS': 'assets/dbs.png',
    'ID': 'assets/idcheck.png',
    'AC': 'assets/fact_check_24d.png',
    'ACC': 'assets/acc.png'
        ''
    // Add more mappings as needed
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 5, // Blur radius
                  offset: const Offset(0, 2), // Changes position of shadow
                ),
              ],
            ),
            child: AppBar(
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
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
                      const PopupMenuItem<int>(
                          value: 3, child: Text("Settings")),
                      const PopupMenuItem<int>(
                          value: 4, child: Text("Notifications")),
                      const PopupMenuDivider(),
                      const PopupMenuItem<int>(
                        value: 5,
                        child: Row(
                          children: [
                            Icon(Icons.logout, color: Colors.red),
                            SizedBox(width: 10),
                            Text("Log Out",
                                style: TextStyle(color: Colors.red)),
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
                        Text('John Smith',
                            style: TextStyle(color: Colors.black)),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          DashboardContent(),
        ],
      ),
    );
  }

  // Menu item builder with underline for selected item
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

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  final FirestoreService firestoreService = FirestoreService();

  final Map<String, String> checkImages = {
    'SMC': 'assets/sms.png',
    'RTW': 'assets/rtwc.png',
    'DBS': 'assets/dbs.png',
    'ID': 'assets/idcheck.png',
    'AC': 'assets/fact_check_24d.png',
    // Add more mappings as needed
  };
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Top section with summary cards and action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Summary Cards
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildSummaryCard(
                        "Total Applicants", "02", const Color(0xFF71C1FF)),
                    buildSummaryCard(
                        "In Progress", "03", const Color(0xFFBEE2FF)),
                    buildSummaryCard("Further Action Pending", "02",
                        const Color(0xFF71C1FF)),
                    buildSummaryCard(
                        "Staff Review Pending", "03", const Color(0xFFBEE2FF)),
                    buildSummaryCard(
                        "Completed", "02", const Color(0xFF71C1FF)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Search Bar and Filter Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                children: [
                  SizedBox(
                    width: 600,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFE6EDF3),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        hintText: "Search for applicant",
                        hintStyle: const TextStyle(color: Color(0xFF8E8D8D)),
                        suffixIcon:
                            const Icon(Icons.search, color: Color(0xFF8E8D8D)),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),
                  // Filter Button with Popup
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color(0xFFE6EDF3),
                        borderRadius: BorderRadius.circular(10)),
                    child: PopupMenuButton(
                      color: Colors.white,
                      shadowColor: Colors.transparent,
                      icon: const Icon(Icons.format_list_bulleted_rounded),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Sort by:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const Divider(),
                              ListTile(
                                title:
                                    const Text("Date Created - Latest first"),
                                onTap: () {
                                  // Handle sorting
                                },
                              ),
                              ListTile(
                                title:
                                    const Text("Date Created - Oldest first"),
                                onTap: () {
                                  // Handle sorting
                                },
                              ),
                              ListTile(
                                title: const Text("Alphabetical (A-Z)"),
                                onTap: () {
                                  // Handle sorting
                                },
                              ),
                              ListTile(
                                title: const Text("Alphabetical (Z-A)"),
                                onTap: () {
                                  // Handle sorting
                                },
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Filter:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const Divider(),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Status"),
                              ),
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 4.0,
                                children: [
                                  filterChip("With Employer", Colors.amber),
                                  filterChip("With Applicant", Colors.amber),
                                  filterChip("Done", Colors.green),
                                  filterChip("Not Started", Colors.red),
                                  filterChip("Processing", Colors.orange),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Organization"),
                              ),
                              Wrap(
                                spacing: 8.0,
                                children: [
                                  filterChip("Company A", Colors.blue),
                                  filterChip("Company B", Colors.blue),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 10),

              // Add Applicant Button
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: const Color(0xFF004276),
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AddApplicantScreen()));
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Add applicant',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004276),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          FutureBuilder<List<ApplicantsModels>>(
            future: firestoreService.fetchApplicants(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Error fetching data'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No applicants found'));
              }

              // List of applicants
              List<ApplicantsModels> applicants = snapshot.data!;

              // Responsive Data Table with Light Grey Background
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 244, 244, 244), // Light grey background
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection:
                        Axis.horizontal, // Enable horizontal scrolling
                    child: DataTable(
                      columnSpacing: 100, // Custom space between columns
                      dividerThickness: 0,
                      columns: const [
                        DataColumn(
                            label: Text(
                          "Applicants",
                          style:
                              TextStyle(color: Color(0xFF004276), fontSize: 19),
                        )),
                        DataColumn(
                            label: Text(
                          "Reference",
                          style:
                              TextStyle(color: Color(0xFF004276), fontSize: 19),
                        )),
                        DataColumn(
                            label: Text(
                          "Phone",
                          style:
                              TextStyle(color: Color(0xFF004276), fontSize: 19),
                        )),
                        DataColumn(
                            label: Text(
                          "Company Role",
                          style:
                              TextStyle(color: Color(0xFF004276), fontSize: 19),
                        )),
                        DataColumn(
                            label: Text(
                          "Requested Checks",
                          style:
                              TextStyle(color: Color(0xFF004276), fontSize: 19),
                        )),
                        DataColumn(
                            label: Text(
                          "Status",
                          style:
                              TextStyle(color: Color(0xFF004276), fontSize: 19),
                        )),
                      ],
                      rows: applicants
                          .map((applicant) => buildDataRow(applicant))
                          .toList(),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Helper function to build summary cards
  Widget buildSummaryCard(String title, String value, Color color) {
    return Expanded(
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Color(0xFF004276),
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  value,
                  style: const TextStyle(
                      color: Color(0xFF004276),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build filter chips
  Widget filterChip(String label, Color color) {
    return Chip(
      label: Text(label),
      backgroundColor: color.withOpacity(0.2),
      labelStyle: TextStyle(color: color),
    );
  }

  // Helper function to build each data row
  DataRow buildDataRow(ApplicantsModels applicant) {
    return DataRow(
      cells: [
        DataCell(Text(
          '${applicant.firstName} ${applicant.lastName}',
          style: const TextStyle(
            color: Color(0xFF282828),
            fontSize: 19,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          applicant.email ?? 'N/A',
          style: const TextStyle(
            color: Color(0xFF282828),
            fontSize: 19,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          applicant.phone ?? 'N/A',
          style: const TextStyle(
            color: Color(0xFF282828),
            fontSize: 19,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Text(
          applicant.jobRole ?? 'N/A',
          style: const TextStyle(
            color: Color(0xFF282828),
            fontSize: 19,
            fontWeight: FontWeight.w400,
          ),
        )),
        DataCell(Row(
          children: applicant.selectedProducts != null
              ? applicant.selectedProducts!.map((product) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5.0, top: 2),
                    child: Column(
                      children: [
                        Image.asset(
                          product.image ??
                              'assets/verified_24.png', // Default image if check not found
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          product.subtitle ?? 'DBS',
                          style: TextStyle(
                              color: Color(0xFF004276),
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  );
                }).toList()
              : [const Text('No products selected')],
        )),
        DataCell(Container(
          height: 30,
          width: 150,
          decoration: BoxDecoration(
            color: Color(0xFFFFB0AB),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text("Not Approved",
                style: TextStyle(
                    color: Color(0xFF282828),
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
          ),
        )),
      ],
    );
  }
}

// DataRow buildDataRow(String name, String reference, String organization,
//     String dateCreated, List<String> checks, String status, Color statusColor) {
//   return DataRow(
//     cells: [
//       DataCell(Text(
//         name,
//         style: const TextStyle(
//             color: Color(0xFF282828),
//             fontSize: 19,
//             fontWeight: FontWeight.w400),
//       )),
//       DataCell(Text(
//         reference,
//         style: const TextStyle(
//             color: Color(0xFF282828),
//             fontSize: 19,
//             fontWeight: FontWeight.w400),
//       )),
//       DataCell(Text(
//         organization,
//         style: const TextStyle(
//             color: Color(0xFF282828),
//             fontSize: 19,
//             fontWeight: FontWeight.w400),
//       )),
//       DataCell(Text(
//         dateCreated,
//         style: const TextStyle(
//             color: Color(0xFF282828),
//             fontSize: 19,
//             fontWeight: FontWeight.w400),
//       )),
//       DataCell(Column(
//         children: [
//           Row(
//             children: checks
//                 .map((check) => Padding(
//                       padding: const EdgeInsets.only(right: 5.0, top: 2),
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             checkImages[check] ??
//                                 'assets/default.png', // Default image if check not found
//                             width: 20,
//                             height: 20,
//                           ),
//                           const SizedBox(height: 2),
//                           Text(
//                             check,
//                             style: TextStyle(
//                                 color: Color(0xFF004276),
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                     ))
//                 .toList(),
//           ),
//         ],
//       )),
//       DataCell(Container(
//         padding: const EdgeInsets.all(8.0),
//         decoration: BoxDecoration(
//           color: statusColor.withOpacity(0.2),
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Text(status, style: TextStyle(color: statusColor)),
//       )),
//     ],
//   );
// }
