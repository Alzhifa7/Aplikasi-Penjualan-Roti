import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/customer.dart'; // Updated import to reflect the new name

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<List<Customer>> getCustomer() async {
  final response = await http.get(Uri.parse('$baseUrl/get_customers.php'));

  if (response.statusCode == 200) {
    print(response.body); // Print the JSON response
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    
    if (jsonResponse['success']) {
      List<dynamic> jsonData = jsonResponse['data'];
      return jsonData.map((json) => Customer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data: ${jsonResponse['message']}');
    }
  } else {
    throw Exception('Failed to load data');
  
}


  }
}
