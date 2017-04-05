component {

    private string function datatable( event, rc, prc, args={} ) {

        return "A new booking has been made for " & renderLabel ( "event_detail", args.event_id );
    }

    private string function full( event, rc, prc, args={} ) {

        return renderView(
              view = "/renderers/notifications/newEventBooked/full"
            , args = args
        );
    }

    private string function emailSubject( event, rc, prc, args={} ) {
        return "New Event Booking!";
    }

    private string function emailHtml( event, rc, prc, args={} ) {

        args.dataStruct = deserializeJSON( args.data ?: "" );

        return renderView(
              view = "/renderers/notifications/newEventBooked/emailHtml"
            , args = args.dataStruct
        );
    }

    private string function emailText( event, rc, prc, args={} ) {

        args.dataStruct     = deserializeJSON( args.data ?: "");
        args.firstname      = args.dataStruct.firstname      ?: ""
        args.lastname       = args.dataStruct.lastname       ?: ""
        args.email          = args.dataStruct.email          ?: ""
        args.numberOfSeats  = args.dataStruct.numberOfSeats  ?: 0
        args.session        = args.dataStruct.session        ?: ""
        args.specialRequest = args.dataStruct.specialRequest ?: ""
        args.event_id       = args.dataStruct.event_id       ?: ""
        args.total_price    = args.dataStruct.total_price    ?: -1

        return renderView(
              view = "/renderers/notifications/newEventBooked/emailText"
            , args = args.dataStruct
        );
    }
}