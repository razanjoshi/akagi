$("#cases-body").html("<%= j (render partial: 'case', collection: @cases, as: :case )%>");
