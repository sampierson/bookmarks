module BookmarksHelper
  
  def new_bookmark_link(section)
  link_to_remote('Add Bookmark',
                 :url => new_bookmark_path(:section_id => section),
                 :method => :post,
                 :before => "$('spinner').show();",
                 :after  => "$('spinner').hide();"
                )
  end
                                  
  # SAM: DRY this up
  
  def bookmark_legend_in_place_editor(bookmark)
    id = "bookmark_#{bookmark.id}_legend_in_place_editor"
    if protect_against_forgery?
      url = set_bookmark_legend_path :id => bookmark, :authenticity_token => form_authenticity_token
    else
      url = set_bookmark_legend_path :id => bookmark
    end
    edit_button_id = "bookmark_#{bookmark.id}_legend_edit"
    "<span class=in_place_editor_field id=#{id}>#{bookmark.legend}</span>&nbsp;" +
    "<span id=#{edit_button_id}>#{image_tag('pen.png')}</span>" +
    "<script type='text/javascript'>
    //<![CDATA[
    new Ajax.InPlaceEditor('#{id}', '#{url}', {externalControl: '#{edit_button_id}', externalControlOnly:true})
    //]]>
    </script>"
  end
  
  def bookmark_url_in_place_editor(bookmark)
    id = "bookmark_#{bookmark.id}_url_in_place_editor"
    if protect_against_forgery?
      url = set_bookmark_url_path :id => bookmark, :authenticity_token => form_authenticity_token
    else
      url = set_bookmark_url_path :id => bookmark
    end
    edit_button_id = "bookmark_#{bookmark.id}_url_edit"
    "<span class=in_place_editor_field id=#{id}>#{bookmark.url}</span>&nbsp;" +
    "<span id=#{edit_button_id}>#{image_tag('pen.png')}</span>" +
    "<script type='text/javascript'>
    //<![CDATA[
    new Ajax.InPlaceEditor('#{id}', '#{url}', {externalControl: '#{edit_button_id}', externalControlOnly:true})
    //]]>
    </script>"
  end
  
end
