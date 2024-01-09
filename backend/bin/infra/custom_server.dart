import "package:shelf/shelf.dart";
import "package:shelf/shelf_io.dart" as shelf_io;

class CustomServer {
  Future<void> initialize(Handler handler) async {
    String address = 'localhost';
    int port = 3000;

    await shelf_io.serve(handler, address, port);
    print("Server started at the address 'http://localhost:3000'");
  }
}
