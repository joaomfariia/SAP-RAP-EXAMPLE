CLASS zcl_rap_populate_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_rap_populate_table IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lt_flights    TYPE TABLE OF /dmo/flight,
          lt_insert_tab TYPE TABLE OF /dmo/flight,
          lt_output     TYPE TABLE OF zza_connections.

    DELETE FROM zza_connections.

    SELECT FROM /dmo/flight
        FIELDS *
        ORDER BY carrier_Id, connection_id
        INTO TABLE @lt_flights.

    LOOP AT lt_flights
        INTO DATA(ls_first_date).
* Original table flights has 2 flights per connection. Only process the first
      IF sy-tabix MOD 2 = 0.
        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO lt_output ASSIGNING FIELD-SYMBOL(<ls_output>).
      MOVE-CORRESPONDING ls_first_date TO <ls_output>.
      <ls_output>-uuid = cl_system_uuid=>create_uuid_x16_static( ).

*Extend flight dates by 2000 days
*      DO 2000 TIMES.
*        APPEND ls_first_date TO lt_insert_tab.
*        ls_first_date-flight_date += 1.
*      ENDDO.
* ENDIF.
    ENDLOOP.


* Read highest connection number for each flight
*    SELECT FROM /dmo/flight AS main
*        FIELDS carrier_Id, connection_id, flight_date, price, currency_code, plane_type_id
*        WHERE connection_id = ( SELECT MAX( connection_id ) FROM /dmo/flight WHERE carrier_id = main~carrier_id )
*            AND flight_Date = ( SELECT MIN( flight_date ) FROM /dmo/flight WHERE carrier_id = main~carrier_id AND connection_id = main~connection_id )
*        GROUP BY carrier_id, connection_Id, flight_date, price, currency_code, plane_type_id
*        ORDER BY carrier_id, connection_id
*        INTO TABLE @DATA(lt_max).
*
*
**Add 50 new connection numbers and 2000 days of flights for each
*    LOOP AT lt_max INTO DATA(ls_line).
*      DO 50 TIMES.
*        ls_line-connection_id += 1.
*        ls_line-plane_type_id = SWITCH #( CONV i( ls_line-connection_id ) MOD 2 WHEN 0 THEN 'A330' WHEN 1 THEN 'A350' ).
*
*        ls_first_date = CORRESPONDING #( ls_line ).
*        DATA(lv_repetitions) = COND i( WHEN ls_line-carrier_id = 'LH' AND ls_line-connection_id = '0405' THEN 4000 ELSE 2000 ).
*        DO lv_repetitions TIMES.
*          ls_first_date-seats_max = 220.
*          APPEND INITIAL LINE TO lt_output ASSIGNING FIELD-SYMBOL(<ls_insert>).
*          MOVE-CORRESPONDING ls_first_date TO <ls_insert>.
*          <ls_insert>-uuid = cl_system_uuid=>create_uuid_x16_static( ).
*          ls_first_date-flight_date += 1.
*        ENDDO.
*      ENDDO.
*    ENDLOOP.


*    SORT lt_insert_tab BY carrier_Id connection_id flight_date.
*    DELETE ADJACENT DUPLICATES FROM lt_insert_tab
*        COMPARING carrier_id connection_id flight_date.

    SELECT AirlineID, ConnectionID, DepartureAirport, DestinationAirport, \_DepartureAirport-Name AS DepartureAirportName, \_DepartureAirport-City AS DepartureAirportCity, \_DepartureAirport-CountryCode AS DepartureAirportCountry,
    \_DestinationAirport-Name AS DestinationAirportName, \_DestinationAirport-City AS DestinationAirportCity, \_DestinationAirport-CountryCode AS DestinationAirportCountry
    FROM /DMO/I_Connection
    "WHERE AirlineID = @<ls_output>-carrier_id AND ConnectionID = @<ls_output>-connection_id
    INTO TABLE @DATA(lt_connection).
    SORT lt_connection BY AirlineID ConnectionID.

    LOOP AT lt_output ASSIGNING <ls_output>.
*        SELECT SINGLE DepartureAirport, DestinationAirport, \_DepartureAirport-Name as DepartureAirportName, \_DepartureAirport-City as DepartureAirportCity, \_DepartureAirport-CountryCode as DepartureAirportCountry,
*        \_DestinationAirport-Name as DestinationAirportName, \_DestinationAirport-City as DestinationAirportCity, \_DestinationAirport-CountryCode as DestinationAirportCountry
*        FROM /DMO/I_Connection
*        WHERE AirlineID = @<ls_output>-carrier_id AND ConnectionID = @<ls_output>-connection_id
*        INTO @DATA(ls_connection).
      READ TABLE lt_connection ASSIGNING FIELD-SYMBOL(<ls_connection>)
      WITH KEY AirlineID = <ls_output>-carrier_id
               ConnectionID = <ls_output>-connection_id.
      IF sy-subrc = 0.
        <ls_output>-airport_from_id = <ls_connection>-DepartureAirport.
        <ls_output>-airport_to_id = <ls_connection>-DestinationAirport.
        <ls_output>-city_from = <ls_connection>-departureairportcity.
        <ls_output>-city_to = <ls_connection>-destinationairportcity.
        <ls_output>-country_from = <ls_connection>-departureairportcountry.
        <ls_output>-country_to = <ls_connection>-destinationairportcountry.
      ENDIF.
    ENDLOOP.

    DELETE ADJACENT DUPLICATES FROM lt_output.
    INSERT zza_connections FROM TABLE @lt_output.
    out->write( |Generated { sy-dbcnt } rows in table ZZA_CONNECTIONS| ).
  ENDMETHOD.
ENDCLASS.