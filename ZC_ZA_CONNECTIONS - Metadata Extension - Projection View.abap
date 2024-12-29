@Metadata.layer: #CORE
@UI.headerInfo.title.type: #STANDARD
@UI.headerInfo.title.value: 'Uuid'
@UI.headerInfo.description.type: #STANDARD
@UI.headerInfo.description.value: 'Uuid'
annotate view ZC_ZA_CONNECTIONS with
{
  @EndUserText.label: 'Uuid'
  @UI.facet: [ {
    label: 'General Information',
    id: 'GeneralInfo',
    purpose: #STANDARD,
    position: 10 ,
    type: #IDENTIFICATION_REFERENCE
  } ]
  @UI.identification: [ {
    position: 10 ,
    label: 'Uuid'
  } ]
  @UI.lineItem: [ {
    position: 10 ,
    label: 'Uuid'
  } ]
  @UI.selectionField: [ {
    position: 10
  } ]
  Uuid;

  @UI.identification: [ {
    position: 20
  } ]
  @UI.lineItem: [ {
    position: 20
  } ]
  @UI.selectionField: [ {
    position: 20
  } ]
  CarrierId;

  @UI.identification: [ {
    position: 30
  } ]
  @UI.lineItem: [ {
    position: 30
  } ]
  @UI.selectionField: [ {
    position: 30
  } ]
  ConnectionId;

  @UI.identification: [ {
    position: 40
  } ]
  @UI.lineItem: [ {
    position: 40
  } ]
  @UI.selectionField: [ {
    position: 40
  } ]
  AirportFromId;

  @UI.identification: [ {
    position: 50
  } ]
  @UI.lineItem: [ {
    position: 50
  } ]
  @UI.selectionField: [ {
    position: 50
  } ]
  CityFrom;

  @UI.identification: [ {
    position: 60
  } ]
  @UI.lineItem: [ {
    position: 60
  } ]
  @UI.selectionField: [ {
    position: 60
  } ]
  CountryFrom;

  @UI.identification: [ {
    position: 70
  } ]
  @UI.lineItem: [ {
    position: 70
  } ]
  @UI.selectionField: [ {
    position: 70
  } ]
  AirportToId;

  @UI.identification: [ {
    position: 80
  } ]
  @UI.lineItem: [ {
    position: 80
  } ]
  @UI.selectionField: [ {
    position: 80
  } ]
  CityTo;

  @UI.identification: [ {
    position: 90
  } ]
  @UI.lineItem: [ {
    position: 90
  } ]
  @UI.selectionField: [ {
    position: 90
  } ]
  CountryTo;

  @UI.identification: [ {
    position: 100
  } ]
  @UI.lineItem: [ {
    position: 100
  } ]
  @UI.selectionField: [ {
    position: 100
  } ]
  LocalCreatedBy;

  @UI.identification: [ {
    position: 110
  } ]
  @UI.lineItem: [ {
    position: 110
  } ]
  @UI.selectionField: [ {
    position: 110
  } ]
  LocalCreateAt;

  @UI.identification: [ {
    position: 120
  } ]
  @UI.lineItem: [ {
    position: 120
  } ]
  @UI.selectionField: [ {
    position: 120
  } ]
  LocalLastChangedBy;

  @UI.identification: [ {
    position: 130
  } ]
  @UI.lineItem: [ {
    position: 130
  } ]
  @UI.selectionField: [ {
    position: 130
  } ]
  LocalLastChangedAt;

  @UI.identification: [ {
    position: 140
  } ]
  @UI.lineItem: [ {
    position: 140
  } ]
  @UI.selectionField: [ {
    position: 140
  } ]
  LastChangedAt;
}