@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Connections Data Definition'
define root view entity ZR_ZA_CONNECTIONS
  as select from zza_connections as Connections
{
  key uuid                  as Uuid,
      carrier_id            as CarrierId,
      connection_id         as ConnectionId,
      airport_from_id       as AirportFromId,
      city_from             as CityFrom,
      country_from          as CountryFrom,
      airport_to_id         as AirportToId,
      city_to               as CityTo,
      country_to            as CountryTo,
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_create_at       as LocalCreateAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt

}
