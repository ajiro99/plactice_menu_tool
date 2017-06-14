// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
/*
 *= require jquery-ui
*/
//= require jquery_ujs
//= require turbolinks

// 以下のjsはadministratorでも呼んでいる為、2重で呼び出されている
//= require selectize
//= require moment
//= require datetime_picker
//= require_tree .

$(".datetimepicker").datetimepicker({
  debug: false,
  format: "YYYY-MM-DD(dd) HH:mm",
});

for (var i=6; i<24; i++) {
  var value = String(i)
  if (i < 10) {
    value = '0' + value
  } 
  $('select#practice_schedule_practice_time_4i').children('option[value=' + value + ']').remove();
}

$("#practice_schedule_practice_time_4i").css('width','auto').css('display','inline');
$("#practice_schedule_practice_time_5i").css('width','auto').css('display','inline');

$("#row_0").hide();

$("[id^='category']").change(function(){

  category_id = $(this).val();
  index = $(this).attr("id").substr(9, $(this).attr("id").length);

  $.get("http://" + location.host + "/admin/practice_schedules/category_select",
    { category_id: category_id,
      index: index },
      function(data){ }
  );
});

$("[id^='practice_content_id']").change(function(){

  content_id = $(this).val();
  index = $(this).attr("id").substr(20, $(this).attr("id").length);
 
  $.get("http://" + location.host + "/admin/practice_schedules/plactice_name_select",
    { content_id: content_id,
      index: index },
      function(data){ }
  );
});

$('#append').click(function(){

  index = parseInt($("#row").val()) + 1;
  clone_target = $("#row_0").clone(true).attr("id","row_" + index);
  clone_target.show();
  clone_target.appendTo('#plactice_menu_table');

  replace_id(clone_target, "time_", index);
  replace_id(clone_target, "category_", index);
  replace_id(clone_target, "practice_content_id_", index);
  replace_id(clone_target, "estimated_time_", index);
  replace_id(clone_target, "head_count_", index);
  replace_id(clone_target, "concept_", index);
  replace_id(clone_target, "remove_", index);

  set_no();

  $("#row").val(index);
});

function replace_id(clone_target, replace_target, index) {
  clone_target.find("#" + replace_target).attr("id", replace_target + index);
}

function set_no() {
  var rows = $('#sortable .rank');
  for (var i = 0, rowTotal = rows.length; i < rowTotal; i += 1) {
    $($('.rank')[i]).text(i);
  }
}

$("[id^='remove']").click(function(){
  index = $("[id^='remove']").index(this) + 1 ;
  $( '#plactice_menu_table tr' ).eq( index ).remove();
  set_no();
});

$('#sortable').sortable();
$('#sortable').disableSelection();

$('#sortable').bind('sortstop', function (e, ui) {
  set_no();
})

$(document).ready(function(){
  if($('#edit').length ==0 ){
    $('#append').click();
  } else {
    $("#row").val($('.rank').length - 1);
    $("input[id^='time']").change();
  }
});

$("input[id^='time']").change(function() {
  var sum =0;
  for(i=1; i < $("[id^='time']").length; i++) {
    var count = $("[id='time_" + i + "']").val();
    count = count == ""? 0 : count;
    sum += parseFloat(count);
  }
  $("#total").text('Total: ' + sum + ' Minute');
});