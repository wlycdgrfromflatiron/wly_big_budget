module ApplicationHelper
  def check_boxes_for(collection, names, title, fbo)
    content = "<h3>#{title}</h3>"
    fbo.collection_check_boxes(names, collection, :id, :name) do |b|
      content << "<p>"
        content << "#{b.label { b.check_box + b.text }}"
      content << "</p>"
    end
    content
  end

  def labeled_text_field(fbo, attribute)
    content = "#{fbo.label attribute}"
    content << "#{fbo.text_field attribute}"
    content
  end
end
