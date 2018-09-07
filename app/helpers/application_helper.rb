module ApplicationHelper
  def wly_check_boxes_for(collection, names, title, fbo)
    content = "<h3>#{title}</h3>"
    fbo.collection_check_boxes(names, collection, :id, :name) do |b|
      content << "<p>"
        content << "#{b.label { b.check_box + b.text }}"
      content << "</p>"
    end
    content.html_safe
  end

  def wly_form_div fbo, method, *args, id: '', classes: ''
    content = "<div id='#{id}' class='#{classes}'>"
    content << fbo.send(*args.unshift(method))
    content << "</div>"
    content.html_safe
  end

  def wly_labeled_text_field(fbo, attribute)
    content = "#{fbo.label attribute}"
    content << "#{fbo.text_field attribute}"
    content.html_safe
  end

  def wly_new_link resource_label, resource_name
    content = "<p>"
    helper_method = "new_user_#{resource_name}_path"
    content << "#{link_to resource_label, send(helper_method, @user)}"
    content << "</p>"
    content.html_safe
  end

end
