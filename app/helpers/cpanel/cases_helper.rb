module Cpanel::CasesHelper

  def case_status_for(thecase)
    case thecase.status
    when 1
      "启用"
    when 2
      "关闭"
    else
    end
  end

  def case_status_change_for(thecase)
    if thecase.status == 1
      link_to '', [:close, :cpanel, thecase], class: 'cm-cancle', title: '点击关闭', remote: true
    elsif thecase.status == 2
      link_to '', [:open, :cpanel, thecase],  class: 'fa fa-check', title: '点击开启', remote: true
    else

    end
  end

  def select_for_cases
    return Case.all.collect{|p| [p.title, p.id]}
  end

  def case_display_for(parent_id)
    unless parent_id.present?
      "display:none;"
    end
  end

  def case_parent_for(parent)
    unless parent.nil?
      parent.title
    end
  end

  def case_is_hot_for(is_hot)
    case is_hot
    when 1
      "热门"
    end
  end

end
