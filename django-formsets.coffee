class @Formset
  constructor: (
    @formset_id,
    @form_prefix,
    @empty_form_id
  ) ->

  addGroup: =>
    newForm = $("##{@empty_form_id}").find('.form').clone(true)
    total = @getTotal()

    newForm.find('input').each ->
      if $(this).attr('name')
        name = $(this).attr('name').replace('__prefix__', total)
        id = 'id_' + name
        $(this).attr({'name': name, 'id': id})

    newForm.find('select').each ->
      if $(this).attr('name')
        name = $(this).attr('name').replace('__prefix__', total)
        id = 'id_' + name
        $(this).attr({'name': name, 'id': id})

    newForm.find('label').each ->
      newFor = $(this).attr('for').replace('__prefix__', total)
      $(this).attr('for', newFor)

    $("##{@formset_id}").append(newForm);

    @totalInc()

    return newForm

  removeGroup: (e) =>
    e.remove()
    @totalDec()
    @rebuildGroups()

  totalDec: =>
    total = @getTotal()
    total--
    @setTotal(total)

  totalInc: =>
    total = @getTotal()
    total++
    @setTotal(total)

  getTotal: =>
    return $("#id_#{@form_prefix}-TOTAL_FORMS").val()

  setTotal: (total) =>
    $("#id_#{@form_prefix}-TOTAL_FORMS").val(total)
    console.log total, $("#id_#{@form_prefix}-TOTAL_FORMS").val()

  rebuildGroups: =>
    reg = new RegExp("#{@form_prefix}-[\\d\\.]+-", 'g')
    $("##{@formset_id}").find('.form').each (index, e) =>
      elem = $(e)

      @_rebuildItems(elem.find('input'), index)
      @_rebuildItems(elem.find('select'), index)

      form_prefix = @form_prefix
      elem.find('label').each ->
        newFor = $(this).attr('for').replace(reg, "#{form_prefix}-#{index}-")
        $(this).attr('for', newFor)

  _rebuildItems: (selector, index) =>
    reg = new RegExp("#{@form_prefix}-[\\d\\.]+-", 'g')
    form_prefix = @form_prefix

    selector.each ->
      if $(this).attr('name')
        name = $(this).attr('name').replace(reg, "#{form_prefix}-#{index}-")
        id = 'id_' + name
        $(this).attr({'name': name, 'id': id})
