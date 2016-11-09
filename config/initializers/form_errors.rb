ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if html_tag.include? "input"
    html_tag
  else
    "<p class=\"field_with_errors\">#{html_tag}</p>".html_safe
  end
end
