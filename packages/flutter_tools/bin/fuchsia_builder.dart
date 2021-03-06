// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:args/args.dart';
import 'package:process/process.dart';

import '../lib/src/base/common.dart';
import '../lib/src/base/config.dart';
import '../lib/src/base/context.dart';
import '../lib/src/base/file_system.dart';
import '../lib/src/base/io.dart';
import '../lib/src/base/logger.dart';
import '../lib/src/base/os.dart';
import '../lib/src/base/platform.dart';
import '../lib/src/base/terminal.dart';
import '../lib/src/cache.dart';
import '../lib/src/flx.dart';
import '../lib/src/globals.dart';
import '../lib/src/usage.dart';

const String _kOptionPackages = 'packages';
const String _kOptionOutput = 'output-file';
const String _kOptionHeader = 'header';
const String _kOptionSnapshot = 'snapshot';
const String _kOptionDylib = 'dylib';
const String _kOptionWorking = 'working-dir';
const String _kOptionManifest = 'manifest';
const String _kOptionDepFile = 'depfile';
const String _kOptionBuildRoot = 'build-root';
const List<String> _kRequiredOptions = const <String>[
  _kOptionPackages,
  _kOptionOutput,
  _kOptionHeader,
  _kOptionWorking,
  _kOptionDepFile,
  _kOptionBuildRoot,
];

Future<Null> main(List<String> args) async {
  final AppContext executableContext = new AppContext();
  executableContext.setVariable(Logger, new StdoutLogger());
  executableContext.runInZone(() {
    // Initialize the context with some defaults.
    context.putIfAbsent(Platform, () => const LocalPlatform());
    context.putIfAbsent(FileSystem, () => const LocalFileSystem());
    context.putIfAbsent(ProcessManager, () => const LocalProcessManager());
    context.putIfAbsent(Logger, () => new StdoutLogger());
    context.putIfAbsent(Cache, () => new Cache());
    context.putIfAbsent(Config, () => new Config());
    context.putIfAbsent(OperatingSystemUtils, () => new OperatingSystemUtils());
    context.putIfAbsent(Usage, () => new Usage());
    context.putIfAbsent(AnsiTerminal, () => new AnsiTerminal());
    return run(args);
  });
}

Future<Null> run(List<String> args) async {
  final ArgParser parser = new ArgParser()
    ..addOption(_kOptionPackages, help: 'The .packages file')
    ..addOption(_kOptionOutput, help: 'The generated flx file')
    ..addOption(_kOptionHeader, help: 'The header of the flx file')
    ..addOption(_kOptionDylib, help: 'The generated AOT dylib file')
    ..addOption(_kOptionSnapshot, help: 'The generated snapshot file')
    ..addOption(_kOptionWorking,
        help: 'The directory where to put temporary files')
    ..addOption(_kOptionManifest, help: 'The manifest file')
    ..addOption(_kOptionDepFile, help: 'The generated depfile')
    ..addOption(_kOptionBuildRoot, help: 'The build\'s root directory');
  final ArgResults argResults = parser.parse(args);
  if (_kRequiredOptions
      .any((String option) => !argResults.options.contains(option))) {
    printError('Missing option! All options must be specified.');
    exit(1);
  }
  Cache.flutterRoot = platform.environment['FLUTTER_ROOT'];
  final String outputPath = argResults[_kOptionOutput];
  try {
    final String snapshotPath = argResults[_kOptionSnapshot];
    final String dylibPath = argResults[_kOptionDylib];
    final List<String> dependencies = await assemble(
      outputPath: outputPath,
      snapshotFile: snapshotPath == null ? null : fs.file(snapshotPath),
      dylibFile: dylibPath == null ? null : fs.file(dylibPath),
      workingDirPath: argResults[_kOptionWorking],
      packagesPath: argResults[_kOptionPackages],
      manifestPath: argResults[_kOptionManifest] ?? defaultManifestPath,
      includeDefaultFonts: false,
    );
    final String depFilePath = argResults[_kOptionDepFile];
    final int depFileResult = _createDepfile(
        depFilePath,
        fs.path.relative(argResults[_kOptionOutput],
            from: argResults[_kOptionBuildRoot]),
        dependencies);
    if (depFileResult != 0) {
      printError('Error creating depfile $depFilePath: $depFileResult.');
      exit(depFileResult);
    }
  } on ToolExit catch (e) {
    printError(e.message);
    exit(e.exitCode);
  }
  final int headerResult = _addHeader(outputPath, argResults[_kOptionHeader]);
  if (headerResult != 0) {
    printError('Error adding header to $outputPath: $headerResult.');
  }
  exit(headerResult);
}

int _createDepfile(
    String depFilePath, String target, List<String> dependencies) {
  try {
    final File depFile = fs.file(depFilePath);
    depFile.writeAsStringSync('$target: ${dependencies.join(' ')}\n');
    return 0;
  } catch (_) {
    return 1;
  }
}

int _addHeader(String outputPath, String header) {
  try {
    final File outputFile = fs.file(outputPath);
    final List<int> content = outputFile.readAsBytesSync();
    outputFile.writeAsStringSync('$header\n');
    outputFile.writeAsBytesSync(content, mode: FileMode.APPEND);
    return 0;
  } catch (_) {
    return 1;
  }
}
