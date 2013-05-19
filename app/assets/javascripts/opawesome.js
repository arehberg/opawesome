//= require 'opawesome/cookies'

OptimizatonTestForm = {
  setup: function(){
    $('.edit_test').on('click', '.remove_option', this.remove_attribute);
    $('.edit_test').on('click', '.add_fields', this.add_attribute);
  },

  remove_attribute: function(event){
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('.input').hide();
    event.preventDefault();
  },

  add_attribute: function(event){
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
  }
}

OptimizationTracker = {
  create_session: function(){
    if(Cookies('opt_valid_session') === undefined) {
      $.post('/opawesome/sessions', function(data) {
        // optimization tracking started successfully (we're not doing anything special here yet)
      });
    }
  }
}

$(document).ready(function(){
  OptimizatonTestForm.setup();
  OptimizationTracker.create_session();
});
