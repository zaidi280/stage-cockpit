import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<Alert> alerts = [
    Alert(
      name: 'Test',
      path: 'Stockage > Saif/Ahmed',
      variable: 'Température chambre négative 1',
      min: -10,
      max: 10,
      status: 'green',
    ),
    // Add more Alert instances here
  ];

  List<Employee> employees = [
    Employee(
      name: "John Doe",
      userName: "john.doe",
      email: "john.doe@example.com",
      phone: "1234567890",
    ),
    Employee(
      name: "Jane Smith",
      userName: "jane.smith",
      email: "jane.smith@example.com",
      phone: "0987654321",
    ),
    Employee(
      name: "Alice Johnson",
      userName: "alice.j",
      email: "alice.johnson@example.com",
      phone: "5678901234",
    ),
  ];
  String searchQuery = '';
  bool showSearchBar = false;
  List<Alert> get filteredAlerts {
    return alerts;
  }
  // String _authToken =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NjU0NjMwMDYzYmJkMzRkMDYzYzg3Y2IiLCJyb2xlIjowLCJuYW1lIjoiWWVjaW5lIiwidXNlck5hbWUiOiJCb3VsZWh5YSIsImVtYWlsIjoiZGlyLm9wZXJhdGlvbkB0dW5pZnJpZXMubmV0IiwidXNlckltYWdlIjoidXNlci5wbmciLCJjb21wYW55Ijp7Il9pZCI6IjY0Y2MxZTAxN2YxY2I1YzY1NThmYWFiNCIsIm5hbWUiOiJUVU5JRlJJRVMiLCJpY29uIjoiICJ9LCJzdWIiOiI2NjU0NjMwMDYzYmJkMzRkMDYzYzg3Y2IiLCJpYXQiOjE3MTk4NTc0MDAsImV4cCI6MTcyMDQ1NzQwMH0.HXK7jLsO85Ofb2or_mBjOKkAxG9X34-2yKFYpLUsg0o";

  // List<Alert> get filteredAlerts {
  //   if (searchQuery.isEmpty) return alerts;
  //   return alerts.where((alert) {
  //     return alert.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
  //         alert.path.toLowerCase().contains(searchQuery.toLowerCase()) ||
  //         alert.variable.toLowerCase().contains(searchQuery.toLowerCase());
  //   }).toList();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _setAuthToken(_authToken);
  // }

  // void _setAuthToken(String token) {
  //   setState(() {
  //     _authToken = token;
  //   });
  // }

  // Future<void> _fetchEmployees() async {
  //   const String companyId =
  //       "64cc1e017f1cb5c6558faab4"; // Replace with your companyId
  //   try {
  //     var url =
  //         Uri.parse('https://app.quermes.net/api/user/users-by-company-id');
  //     var body = json.encode({"companyId": companyId});

  //     var response = await http.post(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $_authToken',
  //       },
  //       body: body,
  //     );

  //     if (response.statusCode == 200) {
  //       print(response.body);
  //       var data = json.decode(response.body);
  //       if (data != null && data['users'] is List<dynamic>) {
  //         List<Employee> fetchedEmployees = [];
  //         for (var userData in data['users']) {
  //           fetchedEmployees.add(Employee(
  //             name: userData['name'] ?? '',
  //             userName: userData['userName'] ?? '',
  //             email: userData['email'] ?? '',
  //             phone: userData['phoneNumber'].toString(),
  //           ));
  //         }

  //         setState(() {
  //           employees = fetchedEmployees;
  //         });
  //         _showEmployeeDialog();
  //         print(response.body); // Show the dialog after data is fetched
  //       } else {
  //         print('Invalid data format or null data');
  //       }
  //     } else {
  //       print('Failed to fetch data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //   }
  // }

  void _showEmployeeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Personnes à notifier pour alerte'),
          content: SingleChildScrollView(
            child: Column(
              children: employees.map((employee) {
                return ListTile(
                  title: Text(
                    '${employee.name} (Ingénieur)', // Adding specialty directly here
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(employee.email),
                      Text(employee.phone),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.message, color: Colors.green),
                        onPressed: () {
                          // Logic for sending SMS
                          print("Send SMS to ${employee.name}");
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.email, color: Colors.blue),
                        onPressed: () {
                          // Logic for sending Email
                          print("Send Email to ${employee.name}");
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              child: Text("Fermer", style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('images/icon.png', height: 40),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'QUERMES - Smart Factory',
                style: TextStyle(
                  fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(120, 1, 132, 255),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.account_circle),
            onSelected: (value) {
              if (value == 'logout') {
                Navigator.pushReplacementNamed(context, '/login');
              } else if (value == 'profile') {
                Navigator.pushNamed(context, '/profile');
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'profile',
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.black),
                      SizedBox(width: 8),
                      Text('My Profile'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.black),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: HexColor('#03a9f4'),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('images/profile.jpg'),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Online",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ExpansionTile(
              leading: Icon(Icons.home),
              title: const Text('Home'),
              children: [
                ListTile(
                  title: const Text('Dashboard'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/dashboard');
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.timeline),
              title: const Text('Acquisition'),
              children: [
                ListTile(
                  title: const Text('Acquisition'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/acquisition');
                  },
                ),
                ListTile(
                  title: const Text('Temporelle'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/temporelle');
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.settings),
              title: const Text('Configuration'),
              children: [
                ListTile(
                  title: const Text('Configuration'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/configuration');
                  },
                ),
                ListTile(
                  title: const Text('Alertes'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/notifications');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      showSearchBar = !showSearchBar;
                    });
                  },
                ),
              ],
            ),
            if (showSearchBar)
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search alert',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columnSpacing: 20.0,
                  columns: [
                    DataColumn(
                        label: Text('Name', style: TextStyle(fontSize: 30))),
                    DataColumn(
                        label: Text('Etat', style: TextStyle(fontSize: 30))),
                    DataColumn(
                        label: Text('Actions', style: TextStyle(fontSize: 30))),
                  ],
                  rows: filteredAlerts.map((alert) {
                    return DataRow(
                      cells: [
                        DataCell(
                            Text(alert.name, style: TextStyle(fontSize: 25))),
                        DataCell(Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _getStatusColor(alert.status),
                          ),
                        )),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.notifications_active),
                                onPressed: () {
                                  _showEmployeeDialog();
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    alerts.remove(alert);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'red':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showAlertDetails(Alert alert) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${alert.name}'),
                Text('Path: ${alert.path}'),
                Text('Variable: ${alert.variable}'),
                Text('Min: ${alert.min}'),
                Text('Max: ${alert.max}'),
                Text('Status: ${alert.status}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Alert {
  final String name;
  final String path;
  final String variable;
  final double min;
  final double max;
  final String status;

  Alert({
    required this.name,
    required this.path,
    required this.variable,
    required this.min,
    required this.max,
    required this.status,
  });
}

class Employee {
  final String name;
  final String userName;
  final String email;
  final String phone;

  Employee({
    required this.name,
    required this.userName,
    required this.email,
    required this.phone,
  });
}
