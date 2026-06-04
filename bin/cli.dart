import 'dart:io';
import 'package:http/http.dart' as http;
const version = '0.0.1';

void main(List<String> args){
    print("Hello World");

    if(args.isEmpty){
        print("Hello Dart");
    }
    else if(args.first == 'version'){
        print("Dart CLI version $version");
    }
    else if(args.first == 'search'){
        print("Search command reconized");
        final inputArgs = args.length > 1 ? args.sublist(1) : null;
        search(inputArgs);
    }
    else{
        printUsage();
    }
}

void search(List<String>? args) async{
    print("Seraching for $args");
    final String article;

    if(args == null || args.isEmpty){
        print("Enter article title");
        article = stdin.readLineSync() ?? '';
    }
    else{
        article = args.join(' ');
    }

    print('found $article');
    var articleContent = await getArticle(article);
    print(articleContent);
}

void printUsage(){
  print(
    "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'"
  );
}

Future<String> getArticle(String title) async{
    final url = Uri.https('en.wikipedia.org', '/api/rest_v1/page/summary/$title');
    final response = await http.get(url);
    if(response.statusCode == 200){
        return(response.body);
    }

    return 'Error: Failed to fetch article "$title". Status code: ${response.statusCode}';
}