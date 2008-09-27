module ColumnsHelper
  
  def column_insert_button(column)
    link_to_remote('+', :url => insert_column_before_path(:id => column.id), :method => :post)
  end
  
  def new_section_button(column)
    button_to_remote('New Section', :url => new_section_path(:column_id => column.id), :method => :post)
  end
  
  def add_column_on_right_button
    link_to_remote('+', :url => add_column_on_right_path, :method => :post)
  end
 
  def column_delete_button(column)
    link_to_remote('&otimes;',
      :url => delete_column_path(:id => column.id),
      :method => :delete, 
      :confirm => "Are you sure you wish to delete this column?\n(this operation cannot be undone)")
  end
  
end
