@EndUserText.label : 'Draft Database Table for ZZA_CNNECTIONS_D'
@AbapCatalog.enhancement.category : #EXTENSIBLE_ANY
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zza_cnnections_d {

  key mandt          : mandt not null;
  key uuid           : sysuuid_x16 not null;
  carrierid          : /dmo/carrier_id;
  connectionid       : /dmo/connection_id;
  airportfromid      : /dmo/airport_from_id;
  cityfrom           : zz_city_from;
  countryfrom        : land1;
  airporttoid        : /dmo/airport_to_id;
  cityto             : zz_city_to;
  countryto          : land1;
  localcreatedby     : abp_creation_user;
  localcreateat      : abp_creation_tstmpl;
  locallastchangedby : abp_locinst_lastchange_user;
  locallastchangedat : abp_locinst_lastchange_tstmpl;
  lastchangedat      : abp_lastchange_tstmpl;
  "%admin"           : include sych_bdl_draft_admin_inc;

}