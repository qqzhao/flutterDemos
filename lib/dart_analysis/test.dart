// class MyPlugin extends ServerPlugin with CompletionMixin, DartCompletionMixin {
//   MyPlugin(ResourceProvider provider) : super(provider);
//
//   @override
//   AnalysisDriverGeneric createAnalysisDriver(ContextRoot contextRoot) {
//     // TODO: implement createAnalysisDriver
//     throw UnimplementedError();
//   }
//
//   @override
//   // TODO: implement fileGlobsToAnalyze
//   List<String> get fileGlobsToAnalyze => throw UnimplementedError();
//
//   @override
//   // TODO: implement name
//   String get name => throw UnimplementedError();
//
//   @override
//   // TODO: implement version
//   String get version => throw UnimplementedError();
//
//   @override
//   List<CompletionContributor> getCompletionContributors(String path) {
//     return <CompletionContributor>[new MyCompletionContributor()];
//   }
//
//   @override
//   Future<void> analyzeFile({required AnalysisContext analysisContext, required String path}) {
//     // TODO: implement analyzeFile
//     throw UnimplementedError();
//   }
// }
//
// class MyCompletionContributor implements CompletionContributor {
//   @override
//   Future<void> computeSuggestions(DartCompletionRequest request, CompletionCollector collector) async {
//     // ...
//   }
// }
