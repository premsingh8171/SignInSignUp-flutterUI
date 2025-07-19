import 'package:flutter/material.dart';

class TicketDashboardScreen extends StatelessWidget {

  final List<Map<String, dynamic>> statusCounts = [
    {'title': 'New Tickets', 'count': 0, 'color': Colors.red},
    {'title': 'In Progress Tickets', 'count': 95, 'color': Colors.blue},
    {'title': 'Waiting Tickets', 'count': 11, 'color': Colors.deepPurple},
    {'title': 'Closed Tickets', 'count': 592, 'color': Colors.green},
  ];

  final List<Map<String, String>> tickets = [
    {
      'number': 'UP23062500003',
      'type': 'VOLTAS-RESIDENTIAL COOLER',
      'contact': 'abhishek',
      'mobile': '9560147913',
      'appointment': '30-06-2025',
      'registered': '23-06-2025',
      'model': 'NA',
      'modelNumber': 'NA',
      'location': 'Sahibabad, 201005',
      'complaint': 'COOLER NOT WORKING',
      'status': 'PENDING'
    },
    {
      'number': 'UPAON17062500002',
      'type': 'VOLTAS-RESIDENTIAL COOLER',
      'contact': 'abhishek',
      'mobile': '9560147913',
      'appointment': '17-06-2025',
      'registered': '17-06-2025',
      'model': 'AEON',
      'modelNumber': 'MST-2',
      'location': 'Sahibabad, 201005',
      'complaint': '',
      'status': 'PENDING'
    },
    {
      'number': 'UPAON17062500002',
      'type': 'VOLTAS-RESIDENTIAL COOLER',
      'contact': 'abhishek',
      'mobile': '9560147913',
      'appointment': '17-06-2025',
      'registered': '17-06-2025',
      'model': 'AEON',
      'modelNumber': 'MST-2',
      'location': 'Sahibabad, 201005',
      'complaint': '',
      'status': 'PENDING'
    },
    {
      'number': 'UPAON17062500002',
      'type': 'VOLTAS-RESIDENTIAL COOLER',
      'contact': 'abhishek',
      'mobile': '9560147913',
      'appointment': '17-06-2025',
      'registered': '17-06-2025',
      'model': 'AEON',
      'modelNumber': 'MST-2',
      'location': 'Sahibabad, 201005',
      'complaint': '',
      'status': 'PENDING'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assa Abloy'),
        backgroundColor: Colors.red,
        actions: [Icon(Icons.notifications)],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: statusCounts
                  .map((status) => _StatusCard(
                title: status['title'],
                count: status['count'],
                color: status['color'],
              ))
                  .toList(),
            ),
          ),
          SizedBox(height: 40),

          Expanded(
            child: ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                return _TicketCard(ticket: tickets[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

}

class _StatusCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;

  const _StatusCard({
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 12)),
            SizedBox(height: 4),
            Text('$count',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  final Map<String, String> ticket;

  const _TicketCard({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ticket['number'] ?? '',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(ticket['type'] ?? '',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.person, size: 16),
                SizedBox(width: 4),
                Text('${ticket['contact']}, ${ticket['mobile']}'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16),
                SizedBox(width: 4),
                Text('Appointment: ${ticket['appointment']}'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.date_range, size: 16),
                SizedBox(width: 4),
                Text('Registered: ${ticket['registered']}'),
              ],
            ),

            Row(
              children: [
                Icon(Icons.local_offer, size: 16),
                SizedBox(width: 4),
                Text('Model: ${ticket['model']} (${ticket['modelNumber']})'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.location_on, size: 16),
                SizedBox(width: 4),
                Text(ticket['location'] ?? ''),
              ],
            ),
            if ((ticket['complaint'] ?? '').isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text('Complaint: ${ticket['complaint']}'),
              ),
            SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: Text(ticket['status'] ?? '',
                  style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            )
          ],
        ),
      ),
    );
  }
}




