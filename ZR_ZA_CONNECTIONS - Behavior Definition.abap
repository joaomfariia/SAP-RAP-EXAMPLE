managed implementation in class ZBP_R_ZA_CONNECTIONS unique;
strict ( 2 );
with draft;
define behavior for ZR_ZA_CONNECTIONS alias Connections
persistent table ZZA_CONNECTIONS
draft table ZZA_CNNECTIONS_D
etag master LocalLastChangedAt
lock master total etag LastChangedAt
authorization master( global )

{
  field ( readonly )
   Uuid,
   LocalCreatedBy,
   LocalCreateAt,
   LocalLastChangedBy,
   LocalLastChangedAt,
   LastChangedAt;

  field ( numbering : managed )
   Uuid;


  create;
  update;
  delete;

  draft action Activate optimized;
  draft action Discard;
  draft action Edit;
  draft action Resume;
  draft determine action Prepare;

  mapping for ZZA_CONNECTIONS
  {
    Uuid = uuid;
    CarrierId = carrier_id;
    ConnectionId = connection_id;
    AirportFromId = airport_from_id;
    CityFrom = city_from;
    CountryFrom = country_from;
    AirportToId = airport_to_id;
    CityTo = city_to;
    CountryTo = country_to;
    LocalCreatedBy = local_created_by;
    LocalCreateAt = local_create_at;
    LocalLastChangedBy = local_last_changed_by;
    LocalLastChangedAt = local_last_changed_at;
    LastChangedAt = last_changed_at;
  }

  validation CheckSemanticKey on save { create; update; }
  determination GetCities on save { field AirportFromId, AirportToId; }
}