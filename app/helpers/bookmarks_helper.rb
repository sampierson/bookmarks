module BookmarksHelper
  
  def new_bookmark_link(section)
    link_to_remote('Add Bookmark',
                   :url => new_bookmark_path(:section_id => section),
                   :method => :post,
                   :before => "$('spinner').show();",
                   :after  => "$('spinner').hide();"
                  )
  end
  
  def insert_image_form_link(bookmark)
    content = content_tag(:div, "Click here to install an image", :class => "bookmark_new_image_box")
    link_to_remote(content,
                   :url => bookmark_img_new_path(:id => @bookmark),
                   :method => :get,
                   :before => "$('spinner').show();",
                   :after  => "$('spinner').hide();"
                  )
  end
  
  def image_delete_button(bookmark)
    link_to_remote('&otimes;',
      :url => bookmark_img_delete_path(:id => bookmark),
      :method => :delete, 
      :confirm => "Are you sure you wish to delete this image?\n(this operation cannot be undone)",
      :before => "$('spinner').show();",
      :after  => "$('spinner').hide();")
  end
  
end
