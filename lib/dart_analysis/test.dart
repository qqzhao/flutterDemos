import 'package:analyzer/file_system/file_system.dart';
// ignore: implementation_imports
import 'package:analyzer/src/dart/analysis/driver.dart';
import 'package:analyzer_plugin/plugin/completion_mixin.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/completion/completion_core.dart';

class MyPlugin extends ServerPlugin with CompletionMixin, DartCompletionMixin {
  MyPlugin(ResourceProvider provider) : super(provider);

  @override
  AnalysisDriverGeneric createAnalysisDriver(ContextRoot contextRoot) {
    // TODO: implement createAnalysisDriver
    throw UnimplementedError();
  }

  @override
  // TODO: implement fileGlobsToAnalyze
  List<String> get fileGlobsToAnalyze => throw UnimplementedError();

  @override
  // TODO: implement name
  String get name => throw UnimplementedError();

  @override
  // TODO: implement version
  String get version => throw UnimplementedError();

  @override
  List<CompletionContributor> getCompletionContributors(String path) {
    return <CompletionContributor>[new MyCompletionContributor()];
  }
}

class MyCompletionContributor implements CompletionContributor {
  @override
  Future<void> computeSuggestions(DartCompletionRequest request, CompletionCollector collector) async {
    // ...
  }
}
