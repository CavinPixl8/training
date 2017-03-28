component {

	property name="presideObjectService" inject="presideObjectService";

	private function website( event, rc, prc, args={} ) {

		var qObj = presideObjectService.selectData( objectName=args.object, orderBy="label" )

		args.values=valueArray(qObj.id)
		args.labels=valueArray(qObj.label)


		return renderView(
			  view          = 'formcontrols/checkboxList/index'
			, args          = args
		);
	}
}
