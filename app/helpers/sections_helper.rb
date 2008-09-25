module SectionsHelper
  
  def section_title_in_place_editor(section)
    id = "section#{section.id}_in_place_editor"
    url = set_section_title_path :id => section, :authenticity_token => form_authenticity_token
    edit_button_id = "section_#{section.id}_title_edit"
    "<span class=in_place_editor_field id=#{id}>#{section.title}</span>&nbsp;" +
    "<span id=#{edit_button_id}>#{image_tag('pen.png')}</span>" +
    "<script type='text/javascript'>
    //<![CDATA[
    new Ajax.InPlaceEditor(#{id}, '#{url}', {externalControl: '#{edit_button_id}', externalControlOnly:true})
    //]]>
    </script>"
  end
  
end
