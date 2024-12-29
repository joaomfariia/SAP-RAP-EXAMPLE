@EndUserText.label : 'Flight Connections'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zza_connections {

  key client            : abap.clnt not null;
  key uuid              : sysuuid_x16 not null;
  carrier_id            : /dmo/carrier_id;
  connection_id         : /dmo/connection_id;
  airport_from_id       : /dmo/airport_from_id;
  city_from             : zz_city_from;
  country_from          : land1;
  airport_to_id         : /dmo/airport_to_id;
  city_to               : zz_city_to;
  country_to            : land1;
  local_created_by      : abp_creation_user;
  local_create_at       : abp_creation_tstmpl;
  local_last_changed_by : abp_locinst_lastchange_user;
  local_last_changed_at : abp_locinst_lastchange_tstmpl;
  last_changed_at       : abp_lastchange_tstmpl;

}