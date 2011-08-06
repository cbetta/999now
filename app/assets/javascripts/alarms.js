function prefill_location(loc) {
		$('#alarm_postcode').val(loc.address.postalCode )
}

function failed_location(error) {
	$('#alarm_postcode').val("Could not load...")
}
