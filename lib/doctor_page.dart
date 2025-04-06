import 'package:flutter/material.dart';

class DoctorPage extends StatelessWidget {
  final List<Map<String, String>> doctors = [
    {
      'name': 'Dr. Olivia Turner, M.D.',
      'specialty': 'Hematologist – Iron Deficiency Specialist',
    },
    {
      'name': 'Dr. Ethan Clarke, DNB',
      'specialty': 'Pediatric Hematologist – Childhood Anemia',
    },
    {
      'name': 'Dr. Ava Sharma, M.D.',
      'specialty': 'Clinical Nutritionist – Anemia & Diet Therapy',
    },
    {
      'name': 'Dr. Liam Patel, Ph.D.',
      'specialty': 'Research Scientist – Anemia Genetics',
    },
    {
      'name': 'Dr. Sophia Wang, M.D.',
      'specialty': 'Internal Medicine – Chronic Anemia Management',
    },
    {
      'name': 'Dr. Noah Singh, M.D.',
      'specialty': 'Gastroenterologist – Iron Absorption Disorders',
    },
    {
      'name': 'Dr. Isabella Das, M.D.',
      'specialty': 'Obstetrician – Prenatal & Postpartum Anemia',
    },
    {
      'name': 'Dr. Elijah Nair, M.D.',
      'specialty': 'Onco-Hematologist – Anemia in Cancer Patients',
    },
    {
      'name': 'Dr. Aria Fernandes, DNB',
      'specialty': 'Adolescent Health – Teenage Anemia',
    },
    {
      'name': 'Dr. Ayaan Mehta, M.D.',
      'specialty': 'Nephrologist – Renal Anemia Treatment',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DOCTORS",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search Doctors/Hospitals in your area",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.search, color: Colors.grey),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text("Doctors Nearby",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              SizedBox(height: 10),

              // List of Doctors
              Column(
                children:
                    doctors.map((doctor) => _buildDoctorCard(doctor)).toList(),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorCard(Map<String, String> doctor) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Profile placeholder
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 30, color: Colors.grey),
          ),
          SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor['name'] ?? '',
                  style: TextStyle(
                      color: Colors.blue.shade900,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  doctor['specialty'] ?? '',
                  style: TextStyle(color: Colors.black87),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    _iconButton(Icons.info, Colors.blue),
                    SizedBox(width: 8),
                    _iconButton(Icons.calendar_today, Colors.grey),
                    SizedBox(width: 8),
                    _iconButton(Icons.help_outline, Colors.grey),
                    SizedBox(width: 8),
                    _iconButton(Icons.favorite_border, Colors.grey),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }
}
