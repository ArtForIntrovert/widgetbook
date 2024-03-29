import 'package:analyzer/dart/element/element.dart';
import 'package:dartdoc/dartdoc.dart';

Future<PackageGraph>? _graph;
Future<PackageGraph> getPackageGraph(LibraryElement libraryElement) {
  return _graph ??= Future(() {
    var config = parseOptions(pubPackageMetaProvider, ['inputDir', '.']);
    final packageConfigProvider = PhysicalPackageConfigProvider();
    final packageBuilder = PubPackageBuilder(
      config!,
      pubPackageMetaProvider,
      packageConfigProvider,
    );

    return packageBuilder.buildPackageGraph();
  });
}
