# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
	$('.authorisations input[type=submit]').attr "disabled", false
	$('.authorisations input[type=submit]').click ->
		$(this).attr "disabled", true
		$(this).css "opacity", "0.5"
		$('form').submit()
