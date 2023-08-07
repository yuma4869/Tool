$(function(){
  function getCSRFToken() {
    return $('meta[name=csrf-token]').attr('content');
  }
    $('#taskList').sortable ({ 
      items: '.item',
      update: function(e, ui){ 
        let item = ui.item; 
        let item_data = item.data(); 
        let params = {_method: 'put',authenticity_token: getCSRFToken()}; 
        let index = item.index() - 1; //これをマイナス１しないとうまくいかない
        params[item_data.modelName] = { row_order_position: index};
        $.ajax({
          type: 'POST',
          url: item_data.updateUrl, 
          dataType: 'json',
          data: params
        });
      },
      stop: function(e, ui){ 
        ui.item.children('td').not('.item__status').effect('highlight', { color: "#FFFFCC" }, 500)
      }
    });
  });