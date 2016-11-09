module UsersHelper

  def display_form_error(object, field)
    if object.errors[field].any?
      content_tag(:span, "", class: "fa fa-exclamation-circle fa-2x error-fa") +
      " " + content_tag(:span, object.errors[field].first.upcase)
    end
  end
end
