module ApplicationHelper
  def check_boxes_for(collection, names, title, fbo)
    content = "<h3>#{title}</h3>"
    #fbo.collection_check_boxes(names, collection, :id, :name) do |b|
    #  <p>
    #    b.label { b.check_box + b.text }
    #  </p>
    #end
  end
end
