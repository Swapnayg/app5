// ignore_for_file: unused_local_variable, non_constant_identifier_names, prefer_interpolation_to_compose_strings

library;

import 'dart:async';
import "dart:collection";
import 'dart:convert';
import "dart:core";
import 'dart:io';
import "dart:math";

import 'package:crypto/crypto.dart' as crypto;
import 'package:http/http.dart' as http;

import '../config.dart';

class WooCommerceAPI {
  late String url;
  late String consumerKey;
  late String consumerSecret;
  late bool isHttps;
  Config config = Config();

  WooCommerceAPI(){
    url = config.url;
    consumerKey = config.consumerKey;
    consumerSecret = config.consumerSecret;

    if(url.startsWith("https")){
      isHttps = true;
    } else {
      isHttps = false;
    }
  }

  _getOAuthURL(String request_method, String endpoint) {
    var consumerKey = this.consumerKey;
    var consumerSecret = this.consumerSecret;

    var token = "";
    var token_secret = "";
    var url = "${this.url}/wp-json/wc/v2/$endpoint";
    var containsQueryParams = url.contains("?");

    if(isHttps == true){
      return url + (containsQueryParams == true ? "&consumer_key=${this.consumerKey}&consumer_secret=${this.consumerSecret}" : "?consumer_key=${this.consumerKey}&consumer_secret=${this.consumerSecret}");
    }

    var rand = Random();
    var codeUnits = List.generate(10, (index) {
      return rand.nextInt(26) + 97;
    });

    var nonce =  String.fromCharCodes(codeUnits);
    int timestamp = ( DateTime.now().millisecondsSinceEpoch / 1000).toInt();

    var method = request_method;
    var path = url.split("?")[0];
    var parameters = "oauth_consumer_key=$consumerKey&oauth_nonce=$nonce&oauth_signature_method=HMAC-SHA1&oauth_timestamp=$timestamp&oauth_token=$token&oauth_version=1.0&";

    if (containsQueryParams == true) {
      parameters = parameters + url.split("?")[1];
    } else {
      parameters = parameters.substring(0, parameters.length - 1);
    }

    Map<dynamic, dynamic> params = QueryString.parse(parameters);
    Map<dynamic, dynamic> treeMap = SplayTreeMap<dynamic, dynamic>();
    treeMap.addAll(params);

    String parameterString = "";

    for (var key in treeMap.keys) {
      parameterString = "$parameterString${Uri.encodeQueryComponent(key)}=" + treeMap[key] +"&";
    }

    parameterString = parameterString.substring(0, parameterString.length - 1);

    var baseString = "$method&${Uri.encodeQueryComponent(
            containsQueryParams == true ? url.split("?")[0] : url)}&${Uri.encodeQueryComponent(parameterString)}";

    var signingKey = "$consumerSecret&$token";
    var hmacSha1 =
    crypto.Hmac(crypto.sha1, utf8.encode(signingKey)); // HMAC-SHA1
    var signature = hmacSha1.convert(utf8.encode(baseString));

    var finalSignature = base64Encode(signature.bytes);

    var requestUrl = "";

    if (containsQueryParams == true) {
      requestUrl = "${url.split("?")[0]}?$parameterString&oauth_signature=${Uri.encodeQueryComponent(finalSignature)}";
    } else {
      requestUrl = "$url?$parameterString&oauth_signature=${Uri.encodeQueryComponent(finalSignature)}";
    }

    return requestUrl;
  }

  Future<http.Response> getAsync(String endPoint) async {
    var url = _getOAuthURL("GET", endPoint);
    final response = await http.get(url);
    return response;
  }

  Future<http.Response> getproductAddons(String endPoint) async {
    var url = _getgetProductAddonsURL("GET", endPoint);
    final response = await http.get(url);
    return response;
  }

  _getgetProductAddonsURL(String request_method, String endpoint) {
    var consumerKey = this.consumerKey;
    var consumerSecret = this.consumerSecret;

    var token = "";
    var token_secret = "";
    var url = "${this.url}/wp-json/wc-product-add-ons/v1/$endpoint";
    var containsQueryParams = url.contains("?");

    if(isHttps == true){
      return url + (containsQueryParams == true ? "&consumer_key=${this.consumerKey}&consumer_secret=${this.consumerSecret}" : "?consumer_key=${this.consumerKey}&consumer_secret=${this.consumerSecret}");
    }

    var rand = Random();
    var codeUnits = List.generate(10, (index) {
      return rand.nextInt(26) + 97;
    });

    var nonce = String.fromCharCodes(codeUnits);
    int timestamp = (DateTime.now().millisecondsSinceEpoch / 1000).toInt();

    var method = request_method;
    var path = url.split("?")[0];
    var parameters = "oauth_consumer_key=$consumerKey&oauth_nonce=$nonce&oauth_signature_method=HMAC-SHA1&oauth_timestamp=$timestamp&oauth_token=$token&oauth_version=1.0&";

    if (containsQueryParams == true) {
      parameters = parameters + url.split("?")[1];
    } else {
      parameters = parameters.substring(0, parameters.length - 1);
    }

    Map<dynamic, dynamic> params = QueryString.parse(parameters);
    Map<dynamic, dynamic> treeMap = SplayTreeMap<dynamic, dynamic>();
    treeMap.addAll(params);

    String parameterString = "";

    for (var key in treeMap.keys) {
      parameterString = "$parameterString${Uri.encodeQueryComponent(key)}=" +
          treeMap[key] +
          "&";
    }

    parameterString = parameterString.substring(0, parameterString.length - 1);

    var baseString = "$method&${Uri.encodeQueryComponent(
            containsQueryParams == true ? url.split("?")[0] : url)}&${Uri.encodeQueryComponent(parameterString)}";

    var signingKey = "$consumerSecret&$token";
    var hmacSha1 =
    crypto.Hmac(crypto.sha1, utf8.encode(signingKey)); // HMAC-SHA1
    var signature = hmacSha1.convert(utf8.encode(baseString));

    var finalSignature = base64Encode(signature.bytes);

    var requestUrl = "";

    if (containsQueryParams == true) {
      requestUrl = "${url.split("?")[0]}?$parameterString&oauth_signature=${Uri.encodeQueryComponent(finalSignature)}";
    } else {
      requestUrl = "$url?$parameterString&oauth_signature=${Uri.encodeQueryComponent(finalSignature)}";
    }

    return requestUrl;
  }

  Map removeNullAndEmptyParams(Map<String, Object> data) {
    final keys = data.keys.toList(growable: false);
    for (String key in keys) {
      final value = data[key];
      if (value == null) {
        data.remove(key);
      } else if (value is String) {
        if (value.isEmpty) {
          data.remove(key);
        }
      } else if (value is Map) {
        data[key] = removeNullAndEmptyParams(value.cast<String, Object>());
      } else if(value is List){
        for (var item in value) {
          if(item is Map) {
            item = removeNullAndEmptyParams(item.cast<String, Object>());
          } else if(item == null) {
            value.remove(item);
          } else if(item is String && item.isEmpty) {
            value.remove(item);
          }
        }
      }
    }
    return data;
  }

  Future<http.Response> postAsync(String endPoint, Map data) async {
    var url = _getOAuthURL("POST", endPoint);
    data = removeNullAndEmptyParams(data.cast<String, Object>());

    final response = await http.post(Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
        },
        body: json.encode(data)
    );
    return response;
  }

  Future<http.Response> putAsync(String endPoint, Map data) async {
    var url = _getOAuthURL("PUT", endPoint);
    data = removeNullAndEmptyParams(data.cast<String, Object>());

    final response = await http.put(Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: json.encode(data)
    );
    return response;
  }

  Future<http.Response> deleteAsync(String endPoint) async {
    var url = _getOAuthURL("DELETE", endPoint);

    final response = await http.delete(url);

    return response;
    //return json.decode(response.body);
  }
}

class QueryString {
  static Map parse(String query) {
    var search = RegExp('([^&=]+)=?([^&]*)');
    var result = {};

    if (query.startsWith('?')) query = query.substring(1);

    decode(String s) => Uri.decodeComponent(s.replaceAll('+', ' '));

    for (Match match in search.allMatches(query)) {
      result[decode(match.group(1) ?? '')] = decode(match.group(2) ?? '');
    }

    return result;
  }
}