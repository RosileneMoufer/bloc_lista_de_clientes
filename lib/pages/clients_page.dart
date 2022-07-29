import 'dart:math';

import 'package:bloc_lista_de_clientes/bloc/client_bloc.dart';
import 'package:bloc_lista_de_clientes/bloc/client_event.dart';
import 'package:bloc_lista_de_clientes/bloc/client_state.dart';
import 'package:bloc_lista_de_clientes/model/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({Key? key}) : super(key: key);

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  late final ClientBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = ClientBloc();
    bloc.add(LoadClientEvent());
  }

  @override
  void dispose() {
    super.dispose();

    bloc.close();
  }

  String randomName() {
    final rand = Random();

    return [
      'Maria Alessandra',
      'Lilian Albuquerque',
      'Alberto Linus Garcia',
      'Diana Diniz de Linus Garcia',
      'Ricardo Diniz Linus Garcia'
    ].elementAt(rand.nextInt(5));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              bloc.add(AddClientEvent(client: Client(name: randomName())));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: BlocBuilder<ClientBloc, ClientState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is ClientInitialState) {
              } else if (state is ClientSuccessState) {
                final clientsList = state.clients;

                return ListView.separated(
                  itemCount: clientsList!.length,
                  itemBuilder: ((context, index) => ListTile(
                        leading: CircleAvatar(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child:
                                Text(clientsList[index].name!.substring(0, 1)),
                          ),
                        ),
                        title: Text(clientsList[index].name!),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            // add de adicionar evento.
                            bloc.add(
                                RemoveClientEvent(client: clientsList[index]));
                          },
                        ),
                      )),
                  separatorBuilder: ((context, index) => const Divider()),
                );
              }
              return Container();
            }),
      ),
    );
  }
}
