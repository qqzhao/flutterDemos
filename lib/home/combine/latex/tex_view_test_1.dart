import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class TexTest1 extends StatefulWidget {
  @override
  _TexTest1State createState() => _TexTest1State();
}

class _TexTest1State extends State<TexTest1> {
  var docText = '<h3>What is the correct <h1>xxx</h1>form of quadratic formula?</h3>';
  var docText2 = """
  <div class='jl_exam'><div class='jl_stem' data-type='1'><div class='jl_stem_content'>2019年台州市计划安排重点建设项目344个，总投资595200000000元．用科学记数法可将595200000000表示为( &nbsp; &nbsp;)</div><div class='jl_options jl_row1_col4'><div class='jl_option' identifier=A><span class='number'>A.</span><div class='jl_option_content'>5.952&times;10<sup>11</sup></div></div><div class='jl_option' identifier=B><span class='number'>B.</span><div class='jl_option_content'>59.52&times;10<sup>10</sup></div></div><div class='jl_option' identifier=C><span class='number'>C.</span><div class='jl_option_content'>5.952&times;10<sup>12</sup></div></div><div class='jl_option' identifier=D><span class='number'>D.</span><div class='jl_option_content'>5952&times;10<sup>9</sup></div></div></div></div></div>
  """;
  var docText3 = """
  <div class='jl_exam_1'><div class=\"jl_exam\">\n <div class=\"jl_stem\" data-type=\"1\">\n  <div class=\"jl_stem_content\">\n   2019年台州市计划安排重点建设项目344个，总投资595200000000元．用科学记数法可将595200000000表示为( &nbsp; &nbsp;)\n  </div>\n  <div class=\"jl_options jl_row1_col4\"><div class=\"jl_option\" identifier=\"A\">\n    <span class=\"number\">A.</span>\n    <div class=\"jl_option_content\">\n     5.952×10\n     <sup>11</sup>\n    </div>\n   </div><div class=\"jl_option\" identifier=\"B\">\n    <span class=\"number\">B.</span>\n    <div class=\"jl_option_content\">\n     59.52×10\n     <sup>10</sup>\n    </div>\n   </div><div class=\"jl_option\" identifier=\"C\">\n    <span class=\"number\">C.</span>\n    <div class=\"jl_option_content\">\n     5.952×10\n     <sup>12</sup>\n    </div>\n   </div><div class=\"jl_option\" identifier=\"D\">\n    <span class=\"number\">D.</span>\n    <div class=\"jl_option_content\">\n     5952×10\n     <sup>9</sup>\n    </div>\n   </div>\n  </div>\n </div>\n</div></div>
  """;
  var docText4 = """
  <div class='jl_exam'><div class='jl_stem' data-type='1'><div class='jl_stem_content'>计算<img data-latex=\"\frac{a-1}{a}+\\frac{1}{a}\" src=\"http://qbms.oss-cn-hangzhou.aliyuncs.com/3/201912/9cc1686f26214aaabe806d5907697333.png\">，正确的结果是( &nbsp; &nbsp;)</div><div class='jl_options jl_row1_col4'><div class='jl_option' identifier=A><span class='number'>A.</span><div class='jl_option_content'>1</div></div><div class='jl_option' identifier=B><span class='number'>B.</span><div class='jl_option_content'><img data-latex=\"\frac{1}{2}\" src=\"http://qbms.oss-cn-hangzhou.aliyuncs.com/3/201703/0000781064074c239a4b341e09c3e64b.png\"></div></div><div class='jl_option' identifier=C><span class='number'>C.</span><div class='jl_option_content'>a</div></div><div class='jl_option' identifier=D><span class='number'>D.</span><div class='jl_option_content'><img data-latex=\"\frac{1}{a}" src=\"http://qbms.oss-cn-hangzhou.aliyuncs.com/3/201801/d7e418877b2547f8b698c555b7a42a23.png\"></div></div></div></div></div>
  """;
  var docText5 = r""" <h2> \( a_0 = \frac{{\hbar }}{{m_e ke^2 }} \)<div>xxx: \(a_0 = \frac{{bar }}{{m_e ke^2 }} \)</div></h2>""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test1'),
      ),
      body: Container(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            height: 400,
            child: TeXView(
              child: TeXViewDocument(docText5,
                  style: TeXViewStyle(
                    backgroundColor: Colors.redAccent,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
