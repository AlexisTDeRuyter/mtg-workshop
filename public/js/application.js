$(document).ready(function() {
  // Nav collapse event listener
  $('.button-collapse').sideNav();

  // Deck add listener
  $('.add-deck').on('submit', function(event) {
    event.preventDefault()
    $(this).find('button').prop('disabled', true)
    $(this).closest('div').find('.errors').remove()

    var $ajax = $.ajax({
      method: $(this).attr('method'),
      url: $(this).attr('action'),
      data: $(this).serialize(),
      dataType: 'JSON',
    })

    $ajax.done(function(response) {
      $('.deck-list').find('tbody').append(response['content'])
      this.reset()
    }.bind(this))

    $ajax.fail(function(response) {
      $(this).closest('div').prepend(response.responseText)
    }.bind(this))

    $ajax.always(function() {
      $(this).find('button').prop('disabled', false)
    }.bind(this))
  })
});
