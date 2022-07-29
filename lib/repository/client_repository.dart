import '../model/client.dart';

class ClientRepository {
  final List<Client> _clients = [];

  List<Client> loadClients() {
    _clients.addAll([
      Client(name: 'José Alcino'),
      Client(name: 'Rodolfo'),
      Client(name: 'Lourenço Augusto'),
      Client(name: 'Bartolomeu'),
    ]);

    return _clients;
  }

  List<Client> addClient(Client client) {
    _clients.add(client);

    return _clients;
  }

  List<Client> removeClient(Client client) {
    _clients.remove(client);

    return _clients;
  }
}
