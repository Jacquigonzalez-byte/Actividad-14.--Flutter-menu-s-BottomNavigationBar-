import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Mensajería',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    PeoplesPage(),
    ChatsPage(),
    CallsPage(),
  ];

  final List<String> _titles = ['Contactos', 'Mensajes', 'Llamadas'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey.shade500,
          selectedFontSize: 13,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_outlined),
              activeIcon: Icon(Icons.people_alt),
              label: 'Peoples',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.phone_outlined),
              activeIcon: Icon(Icons.phone),
              label: 'Calls',
            ),
          ],
        ),
      ),
    );
  }
}

// 1. LISTA DE PERSONAS (PEOPLES)
class PeoplesPage extends StatelessWidget {
  const PeoplesPage({super.key});

  final List<Map<String, dynamic>> peoples = const [
    {'name': 'Juan Pérez', 'status': 'En el trabajo', 'online': true, 'color': Colors.blue},
    {'name': 'María García', 'status': 'Disponible', 'online': true, 'color': Colors.pink},
    {'name': 'Carlos López', 'status': 'Ocupado', 'online': false, 'color': Colors.orange},
    {'name': 'Ana Martínez', 'status': 'En la escuela', 'online': true, 'color': Colors.purple},
    {'name': 'Luis Fernández', 'status': 'Solo emergencias', 'online': false, 'color': Colors.green},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      itemCount: peoples.length,
      itemBuilder: (context, index) {
        final person = peoples[index];
        return Card(
          elevation: 0.8,
          margin: const EdgeInsets.symmetric(vertical: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: person['color'],
                  child: Text(
                    person['name'][0],
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                if (person['online'])
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            title: Text(
              person['name'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              person['status'],
              style: TextStyle(color: Colors.grey.shade600),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.person_add_alt_1, color: Colors.teal),
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }
}

// 2. LISTA DE CHATS
class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  final List<Map<String, dynamic>> chats = const [
    {'name': 'Juan Pérez', 'msg': '¿Hola, cómo estás?', 'time': '10:30 AM', 'unread': 2, 'color': Colors.blue},
    {'name': 'María García', 'msg': 'Nos vemos al rato en la clase', 'time': '09:15 AM', 'unread': 0, 'color': Colors.pink},
    {'name': 'Carlos López', 'msg': 'Ya envié la tarea', 'time': 'Ayer', 'unread': 1, 'color': Colors.orange},
    {'name': 'Grupo de Proyecto', 'msg': 'Ana: Ya quedó listo el código', 'time': 'Ayer', 'unread': 0, 'color': Colors.teal},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        final bool hasUnread = chat['unread'] > 0;

        return Card(
          elevation: 0.8,
          margin: const EdgeInsets.symmetric(vertical: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: chat['color'],
              child: Text(
                chat['name'][0],
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            title: Text(
              chat['name'],
              style: TextStyle(
                fontWeight: hasUnread ? FontWeight.bold : FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              chat['msg'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: hasUnread ? Colors.black87 : Colors.grey.shade600,
                fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat['time'],
                  style: TextStyle(
                    fontSize: 12,
                    color: hasUnread ? Colors.teal : Colors.grey,
                    fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 4),
                if (hasUnread)
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.teal,
                    child: Text(
                      '${chat['unread']}',
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  )
                else
                  const Icon(Icons.done_all, size: 16, color: Colors.blue),
              ],
            ),
          ),
        );
      },
    );
  }
}

// 3. LISTA DE LLAMADAS (CALLS)
class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  final List<Map<String, dynamic>> calls = const [
    {'name': 'Ana Martínez', 'type': 'Entrante', 'date': 'Hoy, 08:20 AM', 'isMissed': false},
    {'name': 'Luis Fernández', 'type': 'Perdida', 'date': 'Hoy, 07:45 AM', 'isMissed': true},
    {'name': 'María García', 'type': 'Saliente', 'date': 'Ayer, 06:10 PM', 'isMissed': false},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      itemCount: calls.length,
      itemBuilder: (context, index) {
        final call = calls[index];
        final bool isMissed = call['isMissed'];

        return Card(
          elevation: 0.8,
          margin: const EdgeInsets.symmetric(vertical: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: isMissed ? Colors.red.shade50 : Colors.green.shade50,
              child: Icon(
                isMissed ? Icons.call_missed : (call['type'] == 'Entrante' ? Icons.call_received : Icons.call_made),
                color: isMissed ? Colors.red : Colors.green,
              ),
            ),
            title: Text(
              call['name'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isMissed ? Colors.red.shade700 : Colors.black87,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(
                  isMissed ? Icons.call_missed : Icons.access_time,
                  size: 14,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  '${call['type']} • ${call['date']}',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.phone, color: Colors.teal),
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }
}