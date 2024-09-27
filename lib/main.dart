import 'package:flutter/material.dart';
import 'package:looplus_core/looplus_core.dart';

void main() {
  runApp(
    AppWidget(
      endpoints: LoopCoreEndpoints(
        clientDomain: 'clube.clinicatattyberno.com.br',
        apiUrl: 'https://api.loopmais.net.br/api/v1',
        storageUrl: 'https://storage.googleapis.com/loopmais',
      ),
    ),
  );
}
