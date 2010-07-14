function toggleBasedOnChecked(checkbox, target, target2) {
  jQuery(checkbox).click( 
    	function() {
          if(this.checked){
            jQuery(target).css("display", "table-row");
            jQuery(target2).css("display", "none");
          }else{
            jQuery(target).css("display", "none");
            jQuery(target2).css("display", "table-row");
         }
  	 }
   );
}
function initVideoForm() {
  if (jQuery('#product_is_video').is(':checked')) {
	jQuery('tr.video-form').css('display', 'table-row');
	jQuery('tr.non-video-form').css('display','none');
  }else{
	jQuery('tr.video-form').css('display', 'none');
	jQuery('tr.non-video-form').css('display','table-row');
  };
  toggleBasedOnChecked('td.is-video :checkbox', 'tr.video-form', 'tr.non-video-form');
}

jQuery(document).ready(function () {
  jQuery("body").addClass("jsenabled");
  initVideoForm();
}
);