function toggleBasedOnChecked(checkbox, target, target2) {
  jQuery(checkbox).click( 
    	function() {
          if(this.checked){
            jQuery(target).css("display", "block");
            jQuery(target2).css("display", "none");
          }else{
            jQuery(target).css("display", "none");
            jQuery(target2).css("display", "block");
         }
  	 }
   );
}
function initVideoForm() {
  if (jQuery('#product_is_video').is(':checked')) {
	jQuery('tr.video-form').css('display', 'table-row');
	jQuery('fieldset.video-form').css('display', 'block');
	jQuery('.non-video-form').css('display','none');
  }else{
	jQuery('.video-form').css('display', 'none');
	jQuery('tr.non-video-form').css('display','table-row');
	jQuery('fieldset.non-video-form').css('display','block');
  };
  toggleBasedOnChecked('dd.form-option.is-video :checkbox', 'fieldset.video-form', '.non-video-form');
}

jQuery(document).ready(function () {
  jQuery("body").addClass("jsenabled");
  initVideoForm();
}
);