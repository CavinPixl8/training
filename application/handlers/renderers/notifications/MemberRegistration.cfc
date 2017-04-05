component {

    private string function datatable( event, rc, prc, args={} ) {

        return "We have a new member: " & args.display_name;
    }

    private string function full( event, rc, prc, args={} ) {

        return renderView(
              view = "/renderers/notifications/memberRegistration/full"
            , args = args
        );
    }

    private string function emailSubject( event, rc, prc, args={} ) {
        return "A new member has registed on the website";
    }

    private string function emailHtml( event, rc, prc, args={} ) {

        args.dataStruct = deserializeJSON( args.data ?: "" );

        return renderView(
              view = "/renderers/notifications/memberRegistration/emailHtml"
            , args = args.dataStruct
        );
    }

    private string function emailText( event, rc, prc, args={} ) {

         args.dataStruct    = deserializeJSON( args.data ?: "" );
         args.login_id      = args.dataStruct.login_id      ?: "";
         args.email_address = args.dataStruct.email_address ?: "";
         args.display_name  = args.dataStruct.display_name  ?: "";
         args.firstname     = args.dataStruct.firstname     ?: "";
         args.lastname      = args.dataStruct.lastname      ?: "";
         args.dob           = args.dataStruct.dob           ?: "";
         args.gender        = args.dataStruct.gender        ?: "";
         args.address       = args.dataStruct.address       ?: "";
         args.category      = args.dataStruct.category      ?: "";

        return renderView(
              view = "/renderers/notifications/memberRegistration/emailText"
            , args = args
        );
    }
}