module ColumnsHelper
  
  def make_column_drop_target(column)
    drop_receiving_element(column.dom_id,
      :accept => 'section',
      :before => "$('spinner').show();",
      :complete => "$('spinner').hide();",
      :hoverclass => 'hover',
      :with => "'id=' + encodeURIComponent(element.id.split('_').last())",
      :url => drop_section_path(:column_id => column.id))
  end
  
end
