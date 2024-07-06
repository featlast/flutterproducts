// import 'dart:convert';
// import 'package:http/http.dart' as http;

// enum HttpMethod { get, post, put, patch, delete }

// class ProductService {
//   static const String baseUrl = 'http://10.0.2.2:3001/api/product';

//   Future<dynamic> _makeRequest(
//     String endpoint,
//     HttpMethod method, {
//     Map<String, dynamic>? body,
//   }) async {
//     final Uri url = Uri.parse('$baseUrl$endpoint');
//     final headers = {'Content-Type': 'application/json'};

//     http.Response response;
//     try {
//       switch (method) {
//         case HttpMethod.get:
//           response = await http.get(url, headers: headers);
//           break;
//         case HttpMethod.post:
//           response =
//               await http.post(url, headers: headers, body: jsonEncode(body));
//           break;
//         case HttpMethod.put:
//           response =
//               await http.put(url, headers: headers, body: jsonEncode(body));
//           break;
//         case HttpMethod.patch:
//           response =
//               await http.patch(url, headers: headers, body: jsonEncode(body));
//           break;
//         case HttpMethod.delete:
//           response = await http.delete(url, headers: headers);
//           break;
//       }

//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         return response.body.isNotEmpty ? jsonDecode(response.body) : null;
//       } else {
//         throw Exception('HTTP error ${response.statusCode}');
//       }
//     } catch (error) {
//       throw Exception('Error in ${method.toString()}: $error');
//     }
//   }

//   Future<void> deleteProduct(int? productId) async {
//     await _makeRequest('/$productId', HttpMethod.delete);
//     await reloadProducts();
//   }

//   Future<void> editProduct(int? productId, Product updatedProduct) async {
//     await _makeRequest(
//       '/$productId',
//       HttpMethod.patch,
//       body: updatedProduct.toJson(),
//     );
//     await reloadProducts();
//   }

//   Future<void> reloadProducts() async {
//     // Implementa la lógica para recargar los productos
//   }
// }
