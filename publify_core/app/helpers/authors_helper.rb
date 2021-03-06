module AuthorsHelper
  include BlogHelper

  def display_profile_item(item, item_desc)
    return if item.blank?
    item = link_to(item, item) if is_url?(item)
    content_tag :li do
      safe_join([item_desc, item], ' ')
    end
  end

  def is_url?(str)
    [URI::HTTP, URI::HTTPS].include?(URI.parse(str.to_s).class)
  rescue URI::InvalidURIError
    false
  end

  def author_description(user)
    return if user.description.blank?

    content_tag(:div, user.description, id: 'author-description')
  end

  def author_link(article)
    return h(article.author) if just_author?(article.user)
    return h(article.user.name) if just_name?(article.user)
    content_tag(:a, href: "mailto:#{h article.user.email}") { h(article.user.name) }
  end

  private

  def just_author?(author)
    author.nil? || author.name.blank?
  end

  def just_name?(author)
    author.present? && !this_blog.link_to_author
  end
end
