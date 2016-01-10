$(document).ready ->
  nothing = ->
    $('#results').val('').append('<li>the Force found nothing</li>')
    false

  $(document).on 'submit', '#search_form', (e)->
    e.preventDefault()
    q = $('#q').val()
    url = $(@).data('url')
    return false if q == '' or url == ''

    $.ajax
      url: url
      type: 'GET'
      data: {q: q}
      dataType: 'json'
      success: (data)->
        return nothing() unless data and data.length
        $res = $('#results')
        $res.html('')
        for lang in data
          $res.append """
            <li>
              <h4>#{lang['Name']}</h4>
              <p>Type: #{lang['Type']}</p>
              <small>Designed by: #{lang['Designed by']}</small>
            </li>
          """
    false
