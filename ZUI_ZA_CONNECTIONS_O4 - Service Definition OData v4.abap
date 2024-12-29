@EndUserText: {
  label: 'Service Definition for ZC_ZA_CONNECTIONS'
}
@ObjectModel: {
  leadingEntity: {
    name: 'ZC_ZA_CONNECTIONS'
  }
}
define service ZUI_ZA_CONNECTIONS_O4 provider contracts odata_v4_ui {
  expose ZC_ZA_CONNECTIONS as Connections;
}