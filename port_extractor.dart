import 'dart:convert';
import 'dart:io';

void main() async {
  PortExtractor pe = PortExtractor();
  final port = await pe.extractPort();
  print("port: $port");
}

class PortExtractor {
  static const _kJsonKeyForPort = "port";
  static const _kJsonKeyForEnvPath = "envPath";
  static const _mockEnvMetaPath = "mock_env_meta.json";

  Future<int> extractPort() async {
    final metaMap = await decodeJson(_mockEnvMetaPath);
    final envMap = await decodeJson(metaMap[_kJsonKeyForEnvPath]);
    return envMap[_kJsonKeyForPort];
  }

  Future<Map<String, dynamic>> decodeJson(String jsonFilePath) async {
    final jsonFile = File(jsonFilePath);
    final jsonStr = await jsonFile.readAsString();
    final Map<String, dynamic> map = json.decode(jsonStr);
    return map;
  }
}
