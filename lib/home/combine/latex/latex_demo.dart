import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:hello/home/combine/latex/tex_view_document_examples.dart';
import 'package:hello/home/combine/latex/tex_view_image_example.dart';
import 'package:hello/home/combine/latex/tex_view_ink_well_example.dart';
import 'package:hello/home/combine/latex/tex_view_quiz_example.dart';
import 'package:hello/home/combine/latex/tex_view_test_1.dart';
import 'package:hello/home/combine/latex/tex_view_test_2.dart';

class FlutterTeXExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TeXViewFullExample();
  }
}

class TeXViewFullExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Flutter TeX (Demo)"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              "assets/images/sound_bg.png",
              fit: BoxFit.contain,
              height: 200,
            ),
          ),
          Divider(
            height: 30,
            color: Colors.transparent,
          ),
          getExampleButton(context, 'Quiz Example', TeXViewQuizExample()),
          getExampleButton(context, 'TeX Examples', TeXViewDocumentExamples()),
          getExampleButton(context, 'Image Example', TeXViewImageExample()),
          getExampleButton(context, 'Inkwell Example', TeXViewInkWellExample()),
          getExampleButton(context, 'my test1', TexTest1()),
          getExampleButton(context, 'WebViewPlusExample test2', WebViewPlusExampleMainPage()),
        ],
      ),
    );
  }

  Widget getExampleButton(BuildContext context, String title, Widget widget) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RaisedButton(
        elevation: 5,
        color: Colors.white,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}

class TeXViewMiniExample extends StatefulWidget {
  @override
  _TeXViewMiniExampleState createState() => _TeXViewMiniExampleState();
}

class _TeXViewMiniExampleState extends State<TeXViewMiniExample> {
  @override
  Widget build(BuildContext context) {
    return TeXView(
      loadingWidgetBuilder: (context) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[CircularProgressIndicator(), Text("Rendering...")],
        ),
      ),
      child: TeXViewColumn(children: [
        TeXViewInkWell(
          id: "id_0",
          child: TeXViewColumn(children: [
            TeXViewDocument(r"""<h2>Flutter \( \rm\\TeX \)</h2>""", style: TeXViewStyle(textAlign: TeXViewTextAlign.Center)),
            TeXViewContainer(
              child: TeXViewImage.network('https://raw.githubusercontent.com/shah-xad/flutter_tex/master/example/assets/flutter_tex_banner.png'),
              style: TeXViewStyle(
                margin: TeXViewMargin.all(10),
                borderRadius: TeXViewBorderRadius.all(20),
              ),
            ),
            TeXViewDocument(r"""<p>                                
                           When \(a \ne 0 \), there are two solutions to \(ax^2 + bx + c = 0\) and they are
                           $$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$</p>""", style: TeXViewStyle.fromCSS('padding: 15px; color: white; background: green'))
          ]),
        )
      ]),
      style: TeXViewStyle(
        elevation: 10,
        borderRadius: TeXViewBorderRadius.all(25),
        border: TeXViewBorder.all(TeXViewBorderDecoration(borderColor: Colors.blue, borderStyle: TeXViewBorderStyle.Solid, borderWidth: 5)),
        backgroundColor: Colors.white,
      ),
    );
  }
}
