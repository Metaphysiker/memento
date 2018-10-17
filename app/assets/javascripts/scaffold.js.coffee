$(document).on 'turbolinks:load', ->

#$ ->
  # enable chosen js
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'Nichts gefunden'
    inherit_select_classes: false
    search_contains: true
    width: '100%'
