if (typeof jQuery !== 'undefined') {
	/*(function($) {
		$('#spinner').ajaxStart(function() {
			$(this).fadeIn();
		}).ajaxStop(function() {
			$(this).fadeOut();
		});
	})(jQuery);*/

    $(document).ready(function () {

        $('.dropdown-toggle').dropdown();
        $('[rel=tooltip]').tooltip();
        $('.nav-tabs').tab();

    });
}
