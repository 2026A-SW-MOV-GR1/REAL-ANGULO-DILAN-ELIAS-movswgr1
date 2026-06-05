import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/database_provider.dart';
import '../widgets/database_switch.dart';
import '../widgets/user_form.dart';
import '../widgets/user_list.dart';

/// Pantalla principal de la aplicación
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Cargamos los usuarios cuando la pantalla se inicializa
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<DatabaseProvider>();
      provider.loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persistencia Dual'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Widget del interruptor de base de datos
          const DatabaseSwitch(),
          // Lista de usuarios
          const Expanded(
            child: UserList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final provider = context.read<DatabaseProvider>();
          showDialog(
            context: context,
            builder: (context) => UserFormDialog(provider: provider),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

