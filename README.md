# django-formset-js (use JQuery)

Simple to use:
1. load script 
1. 
```javascript
  var formset = new Formset('formsetId', 'formPrefix', 'emptyFormId');
  $('#add-answer-btn').click(formset.addGroup);
  $('.delete-answer-btn').click(function(){
      formset.removeGroup($(this).parents('.form'))
  });
```
1. We are happy
