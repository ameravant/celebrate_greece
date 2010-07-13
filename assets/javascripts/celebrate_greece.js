function toggleBasedOnChecked(checkbox, target) {
  jQuery(checkbox).click( 
    	function() {
          if(this.checked){
            jQuery(target).css("display", "table-cell");
          }else{
            jQuery(target).css("display", "none");
         }
  	 }
   );
}
function initVideoForm() {
  toggleBasedOnChecked('td.is-video :checkbox', 'tr.video-form');
}
jQuery(document).ready(function () {
  jQuery("body").addClass("jsenabled");
  initVideoForm();
}
);