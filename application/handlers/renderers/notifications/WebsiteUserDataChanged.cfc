component {

    property name="websiteUserService"  inject="WebsiteUserService";

    private string function datatable( event, rc, prc, args={} ) {

        return "A website user has changed details" ;
    }

    private string function full( event, rc, prc, args={} ) {

        args = websiteUserService.getUser( args.id );

        return renderView(
              view = "/renderers/notifications/websiteUserDataChanged/full"
            , args = args
        );
    }
}