`shelf_rpc` is a Shelf `Handler` for the Dart `rpc` package.

### Example
```
import 'package:rpc/rpc.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_rpc/shelf_rpc.dart' as shelf_rpc;

void main() {
  // Create your RPC API Server.
  ApiServer apiServer = new ApiServer(prettyPrint: true);
  apiServer.addApi(new MyApi());

  // Create a Shelf handler for your RPC API.
  var handler = shelf_rpc.createRpcHandler(apiServer);

  // Start serving with Shelf.
  io.serve(handler, 'localhost', 8080);
}


/// My RPC API definition.
@ApiClass(name: "myApi", version: "v1")
class MyApi {

  /// Returns the requested [Thing].
  @ApiMethod(path: "thing/{id}")
  Thing getStuff(int id) {
    ...
  }

  /// Creates the given [Thing].
  @ApiMethod(path: "thing", method: "POST")
  Thing createThing(Thing thing) {
    ...
  }

  ...
```
