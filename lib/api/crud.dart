
import 'package:http/http.dart' as http;
import 'dart:convert';


class Crud
{


  Future getRequest(String url) async
  {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseBody =  jsonDecode(response.body);
        return responseBody;
      }
      else
      {
        print('Error ${response.statusCode}');
      }
    }
    catch(e)
    {
      print('Error catch $e');
    }
  }


  Future postRequest(String url , Map data) async
  {
    try{
      var response= await http.post(Uri.parse(url),body: data);
      if(response.statusCode==200 || response.statusCode==201)
      {
        var responseBody=  jsonDecode(response.body);
        print(responseBody);
        return responseBody;

      }
      else
      {
        print('Error ${response.statusCode}');
      }
    }
    catch(e)
    {
      print('Error catch $e');
    }
  }


}