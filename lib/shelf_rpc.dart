// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "package:shelf/shelf.dart";
import "package:rpc/rpc.dart";

/// Creates a Shelf [Handler] that translates Shelf [Request]s to rpc's
/// [HttpApiRequest] executes the request on the given [ApiServer] and then
/// translates the returned rpc's [HttpApiResponse] to a Shelf [Response].
Handler createRpcHandler(ApiServer apiServer) {
  return (Request request) {
    try {
      var apiRequest = new HttpApiRequest(request.method, request.url.path,
          request.url.queryParameters, request.headers, request.read());
      return apiServer.handleHttpApiRequest(apiRequest).then(
          (apiResponse) {
            return new Response(apiResponse.status, body: apiResponse.body,
                                headers: apiResponse.headers);
          });
    } catch (e) {
      // Should never happen since the apiServer.handleHttpRequest method
      // always returns a response.
      return new Response.internalServerError(body: e.toString());
    }
  };
}
