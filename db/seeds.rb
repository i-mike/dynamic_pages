# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

def build_page_contents_for_each_language
  Language.all.map do |lng|
    PageContent.new(title: "#{lng.slug}-#{Faker::Lorem.sentence(3)}",
                    body: Faker::Lorem.paragraphs(5).join,
                    language: lng
    )
  end
end


languages = { 'ru' => 'Русский',
              'en' => 'English'}

ActiveRecord::Base.transaction do
  # Add user
  User.create!(nickname: 'admin', password: '12345678')

  # Add languages
  languages.each do |slug, name|
    Language.create!(slug: slug, name: name)
  end

  # Add dummy pages
  1.upto(3) do |i1|
    parent_page = Page.create!(slug: "page-#{i1}", priority: i1)
    parent_page.page_contents = build_page_contents_for_each_language
    parent_page.enabled = true
    parent_page.save!
    1.upto(3) do |i2|
      sub_page = Page.create!(slug: "page-#{i1}-#{i2}", priority: i2, parent_id: parent_page.id)
      sub_page.page_contents = build_page_contents_for_each_language
      sub_page.save!
    end
  end

end