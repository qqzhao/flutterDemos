import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hello/buttons/raise_button.dart';
// import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';

class PdfPreviewPage extends StatefulWidget {
  @override
  _PdfPreviewPageState createState() => _PdfPreviewPageState();
}

class _PdfPreviewPageState extends State<PdfPreviewPage> {
  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    final url = "http://africau.edu/images/default/sample.pdf";
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plugin example app')),
      body: Center(
        child: RaisedButton(
          child: Text("Open PDF"),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PDFScreen(
                      pathPDF: pathPDF,
                    )),
          ),
        ),
      ),
    );
  }
}

class PDFScreen extends StatelessWidget {
  final String pathPDF;
  PDFScreen({this.pathPDF = ""});

  @override
  Widget build(BuildContext context) {
    return Container();
    // return PDFViewerScaffold(
    //     appBar: AppBar(
    //       title: Text("Document"),
    //       actions: <Widget>[
    //         IconButton(
    //           icon: Icon(Icons.share),
    //           onPressed: () {},
    //         ),
    //       ],
    //     ),
    //     path: pathPDF);
  }
}
