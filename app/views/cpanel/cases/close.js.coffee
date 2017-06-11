$("#cases-body").html("<%= j (render partial: 'case', collection: @cases, as: :case )%>");
$("#flash-notice").html("<%= j (render 'cpanel/public/flash_notice') %>");
