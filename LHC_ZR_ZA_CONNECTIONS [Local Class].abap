CLASS lhc_zr_za_connections DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Connections
        RESULT result,

      CheckSemanticKey FOR VALIDATE ON SAVE
        IMPORTING keys FOR Connections~CheckSemanticKey,

      GetCities FOR DETERMINE ON SAVE
        IMPORTING keys FOR Connections~GetCities.
ENDCLASS.

CLASS lhc_zr_za_connections IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD CheckSemanticKey.

    DATA read_keys TYPE TABLE FOR READ IMPORT zr_za_connections.
*    DATA connections TYPE TABLE FOR READ RESULT zr_za_connections.

*   To make the runtime issue the message, we need to report it using this structure
    DATA reported_record LIKE LINE OF reported-connections.
    DATA failed_record LIKE LINE OF failed-connections.

*   What is being processed by the user
    read_keys = CORRESPONDING #( keys ).

*   Read the user input
    READ ENTITIES OF zr_za_connections IN LOCAL MODE
    ENTITY Connections
    FIELDS ( uuid CarrierID ConnectionID AirportFromId AirportToId )
    WITH CORRESPONDING #( keys )
    RESULT DATA(connections).

    IF connections IS NOT INITIAL.
      LOOP AT connections ASSIGNING FIELD-SYMBOL(<connection>).
*       CHECK 01 - Check if the entry already exists in the tables
*       Persistent table
        SELECT FROM zza_connections
            FIELDS uuid
            WHERE carrier_id    EQ @<connection>-CarrierId
              AND connection_id EQ @<connection>-ConnectionId
              AND uuid          NE @<connection>-Uuid
        UNION
*       Draft table
        SELECT FROM zza_cnnections_d
            FIELDS uuid
            WHERE carrierid    EQ @<connection>-CarrierId
              AND connectionid EQ @<connection>-ConnectionId
              AND uuid         NE @<connection>-Uuid
        INTO TABLE @DATA(check_result).

*       The semantic key is already been used!
        IF check_result IS NOT INITIAL.
          DATA(error_msg_001) = me->new_message(
                                        id       = 'ZMSGRAP'
                                        number   = '001'
                                        severity = ms-error
                                        v1       = <connection>-CarrierId
                                        v2       = <connection>-ConnectionId ).

*         To report and issue the message, we must do three things:
*         1) Add the record with error to the reported internal table (Field group %tky - Technical key)
          reported_record-%tky = <connection>-%tky.
*         2) Attach the message object to the reported table
          reported_record-%msg = error_msg_001.
*         3) Bind the message to the affected field(s)
          reported_record-%element-carrierid = if_abap_behv=>mk-on.
          APPEND reported_record TO reported-connections.
          CLEAR reported_record.

*         As well as issuing the message, we must also tell the runtime not to save the incorrect data.
          failed_record-%tky = <connection>-%tky.
*          failed_record = VALUE #( %tky = <connection>-%tky ).
          APPEND failed_record TO failed-connections.
          CLEAR failed_record.
        ENDIF.

*       CHECK 02 - Check if the key exists in the system
        SELECT SINGLE FROM /DMO/I_Carrier
            FIELDS @abap_true
            WHERE AirlineID = @<connection>-CarrierId
            INTO @DATA(exists).
        IF exists NE abap_true. "The entry does not exist in the system
          DATA(error_msg_002) = me->new_message(
                                        id       = 'ZMSGRAP'
                                        number   = '002'
                                        severity = ms-error
                                        v1       = <connection>-CarrierId ).

          reported_record = VALUE #(  %tky = <connection>-%tky
                                      %msg = error_msg_002
                                      %element-carrierid = if_abap_behv=>mk-on ).
          APPEND reported_record TO reported-connections.
          CLEAR reported_record.

          failed_record-%tky = <connection>-%tky.
          APPEND failed_record TO failed-connections.
        ENDIF.

*       CHECK 03 - Check if the Airports are the same
        IF <connection>-AirportFromId EQ <connection>-AirportToId.
          DATA(error_msg_003) = me->new_message(
                                      id       = 'ZMSGRAP'
                                      number   = '003'
                                      severity = ms-error ).
          reported_record = VALUE #( %tky = <connection>-%tky
                                     %msg = error_msg_003 ).
          APPEND reported_record TO reported-connections.

          failed_record-%tky = <connection>-%tky.
          APPEND failed_record TO failed-connections.
        ENDIF.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.

  METHOD GetCities.

*   We need this type of table to appropriately update the entry fields
    DATA connections_upd TYPE TABLE FOR UPDATE zr_za_connections.
    DATA reported_records TYPE RESPONSE FOR REPORTED zr_za_connections.

    READ ENTITIES OF zr_za_connections IN LOCAL MODE
    ENTITY Connections
    FIELDS ( AirportFromId AirportToId )
    WITH CORRESPONDING #( keys )
    RESULT DATA(connections).

    IF connections IS NOT INITIAL.
      LOOP AT connections ASSIGNING FIELD-SYMBOL(<connection>).
        SELECT SINGLE FROM /dmo/i_airport
                    FIELDS City, CountryCode
                    WHERE AirportID EQ @<connection>-AirportFromId
                    INTO ( @<connection>-CityFrom, @<connection>-CountryFrom ).

        SELECT SINGLE FROM /DMO/I_Airport
                    FIELDS City, CountryCode
                    WHERE AirportID EQ @<connection>-AirportToId
                    INTO ( @<connection>-CityTo, @<connection>-CountryTo ).

        connections_upd = CORRESPONDING #( connections ).

        MODIFY ENTITIES OF zr_za_connections IN LOCAL MODE
        ENTITY Connections
        UPDATE
        FIELDS ( CityFrom CountryFrom CityTo CountryTo ) "Fields that should be updated
        WITH connections_upd
        REPORTED reported_records.

        reported-connections = CORRESPONDING #( reported_records-connections ).
      ENDLOOP.
    ENDIF.

  ENDMETHOD.

ENDCLASS.