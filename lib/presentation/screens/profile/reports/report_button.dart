import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import '../../../../common/common.dart';
import '../../../../flavors.dart';
import '../../../../logger.dart';
import '../../../cubits/authentication/auth/auth_cubit.dart';
import '../../../cubits/mutual_funds/report/report_cubit.dart';

const String _h = 'report_button';

class ReportButton extends StatefulWidget {
  const ReportButton({Key? key}) : super(key: key);

  @override
  State<ReportButton> createState() => _ReportButtonState();
}

class _ReportButtonState extends State<ReportButton> {
  late final ReceivePort _port;

  @override
  void initState() {
    super.initState();

    _port = ReceivePort();
    //TODO: Update the download percentage in next release
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    _port.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        'Holdings Report',
        style: TextStyle(fontSize: 12),
      ),
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              context.read<ReportCubit>().generateHoldingsReport(
                  userId: context.read<AuthCubit>().state.user!.id);
            },
            child: BlocConsumer<ReportCubit, ReportState>(
              listener: (context, state) {
                if (state is ReportGenerated) {
                  Utils.downloadFile(
                      context: context,
                      url: '${F.baseUrl}${state.reportUrl}',
                      fileName: 'report_${DateTime.now().toUtc()}.pdf');
                }
                if (state is ReportGenerateError) {
                  Utils.showErrorAlert(
                      context,
                      Utils.getErrorMessage(
                          msg: state.error, errorType: state.errorType));
                }
              },
              builder: (context, state) {
                if (state is ReportGenerating) {
                  return const Text('Generating...');
                }
                return const Text('Download');
              },
            ),
          ),
        ),
      ],
    );
  }
}

void downloadCallback(String id, int status, int progress) {
  if (kDebugMode) {
    logInfo(_h,
        'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
  }
  final SendPort send =
      IsolateNameServer.lookupPortByName('downloader_send_port')!;
  send.send([id, status, progress]);
}
