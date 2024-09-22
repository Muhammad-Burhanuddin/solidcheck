import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'add_applicant.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Keep track of which menu item is selected
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
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
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return constraints.maxWidth > 600
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              offset: const Offset(0, 50),
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
      body: DashboardContent(),
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
              color: _selectedIndex == index ? Colors.blue : Colors.black,
              fontWeight:
                  _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          _selectedIndex == index
              ? Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  height: 2.0,
                  width: 60.0,
                  color: Colors.blue,
                )
              : const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

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
                        "Total Applicants", "02", Color(0xFF71C1FF)),
                    buildSummaryCard("In Progress", "03", Color(0xFFBEE2FF)),
                    buildSummaryCard(
                        "Further Action Pending", "02", Color(0xFF71C1FF)),
                    buildSummaryCard(
                        "Staff Review Pending", "03", Color(0xFFBEE2FF)),
                    buildSummaryCard("Completed", "02", Color(0xFF71C1FF)),
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Search for applicant",
                        suffixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),
                  // Filter Button with Popup
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xFFE6EDF3),
                        borderRadius: BorderRadius.circular(10)),
                    child: PopupMenuButton(
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
                    color: Color(0xFF004276),
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => AddApplicantScreen()));
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
                    backgroundColor: Color(0xFF004276),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Responsive Data Table with Light Grey Background
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                  255, 244, 244, 244), // Light grey background
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                child: DataTable(
                  columnSpacing: 150, // Custom space between columns
                  dividerThickness: 0,
                  columns: const [
                    DataColumn(label: Text("Applicants")),
                    DataColumn(label: Text("Reference")),
                    DataColumn(label: Text("Organization")),
                    DataColumn(label: Text("Date created")),
                    DataColumn(label: Text("Requested Checks")),
                    DataColumn(label: Text("Status")),
                  ],
                  rows: [
                    buildDataRow(
                        "Eduardo Vieira",
                        "638",
                        "companyname",
                        "08/01/2018",
                        ["SMC", "RTW", "+2"],
                        "Not started",
                        Colors.red),
                    buildDataRow(
                        "Eduarda Martins",
                        "770",
                        "companyname",
                        "28/12/2018",
                        ["DBS", "ID"],
                        "With applicant",
                        Colors.amber),
                    buildDataRow("Alice Silva", "649", "companyname",
                        "12/08/2018", ["AC"], "With Employer", Colors.amber),
                    buildDataRow("Pedro Almeida", "774", "companyname",
                        "13/10/2018", ["ID", "AC"], "Processing", Colors.amber),
                    buildDataRow("Thiago Pereira", "417", "companyname",
                        "24/08/2018", ["ID"], "Done", Colors.green),
                    buildDataRow("Henrique Barbosa", "642", "companyname",
                        "18/06/2018", ["AC"], "Done", Colors.green),
                  ],
                ),
              ),
            ),
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
  DataRow buildDataRow(
      String name,
      String reference,
      String organization,
      String dateCreated,
      List<String> checks,
      String status,
      Color statusColor) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Text(reference)),
        DataCell(Text(organization)),
        DataCell(Text(dateCreated)),
        DataCell(Row(
          children: checks
              .map((check) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Chip(label: Text(check)),
                  ))
              .toList(),
        )),
        DataCell(Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(status, style: TextStyle(color: statusColor)),
        )),
      ],
    );
  }
}
