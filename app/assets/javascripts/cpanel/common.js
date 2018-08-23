$(function() {
  $('#case_started_at').datetimepicker({
    format: 'YYYY-MM-DD'
  });
  $('#case_ended_at').datetimepicker({
    format: 'YYYY-MM-DD'
  });
  $("#case_started_at").on("dp.change", function (e) {
      $('#case_ended_at').data("DateTimePicker").minDate(e.date);
  });
  $("#case_ended_at").on("dp.change", function (e) {
      $('#case_started_at').data("DateTimePicker").maxDate(e.date);
  });
});
