import 'package:coronavirus_tracker_app/app/repositories/data_repository.dart';
import 'package:coronavirus_tracker_app/app/repositories/endpoints_data.dart';
import 'package:coronavirus_tracker_app/app/services/api.dart';
import 'package:coronavirus_tracker_app/app/ui/endpoint_card.dart';
import 'package:coronavirus_tracker_app/app/ui/last_updated_status_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointsData;

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endpointData = await dataRepository.getAllEndpointsData();
    setState(() => _endpointsData = endpointData);
  }

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(lastUpdated: _endpointsData != null ? _endpointsData.values[Endpoint.cases].date : null,);
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: <Widget>[
            LastUpdatedStatusText(text: formatter.lastUpdatedStatusText()),
            for (var endpoint in Endpoint.values)
              EndpointCard(
                endpoint: endpoint,
                value: _endpointsData != null ? _endpointsData.values[endpoint].value : null,
              )
          ],
        ),
      ),
    );
  }
}
