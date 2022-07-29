import 'package:bloc_lista_de_clientes/bloc/client_event.dart';
import 'package:bloc_lista_de_clientes/bloc/client_state.dart';
import 'package:bloc_lista_de_clientes/repository/client_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final _clientRepository = ClientRepository();

  // definindo no construtor o estado inicial do meu Bloc.
  ClientBloc() : super(ClientInitialState()) {
    // aqui deve haver a verificação de quando tiver um erro de carregamento.
    on<LoadClientEvent>(
      (event, emit) => emit(
        ClientSuccessState(clients: _clientRepository.loadClients()),
      ),
    );

    on<AddClientEvent>(
      (event, emit) => emit(
        ClientSuccessState(clients: _clientRepository.addClient(event.client!)),
      ),
    );

    on<RemoveClientEvent>(
      (event, emit) => emit(
        ClientSuccessState(
            clients: _clientRepository.removeClient(event.client!)),
      ),
    );
  }
}
