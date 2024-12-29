@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_ZA_CONNECTIONS
  provider contract transactional_query
  as projection on ZR_ZA_CONNECTIONS
{
  key Uuid,
  CarrierId,
  ConnectionId,
  AirportFromId,
  CityFrom,
  CountryFrom,
  AirportToId,
  CityTo,
  CountryTo,
  LocalCreatedBy,
  LocalCreateAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}
