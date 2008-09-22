module ColumnsHelper
  
  def column_insert_button(column)
     link_to_remote('+', :url => insert_column_before_path(:id => column.id), :method => :post)
  end
   
  def column_delete_button(column)
    link_to_remote('&otimes;',
      :url => delete_column_path(:id => column.id),
      :method => :delete, 
      :confirm => "Are you sure you wish to delete this column?\n(this operation cannot be undone)")
  end
  
  #def make_column_drop_target(column)
  #  drop_receiving_element(column.droptarget_id,
  #    :accept     => 'section',
  #    :before     => "$('spinner').show();",
  #    :complete   => "$('spinner').hide();",
  #    :hoverclass => 'hover',
  #    :with       => "'id=' + encodeURIComponent(element.id.split('_').last())",
  #    :url        => drop_section_path(:column_id => column.id))
  #end
  
end
