#!/usr/bin/env ruby

class CreateSkeleton
  require 'fileutils'
  def create_folder str
    FileUtils.mkdir "#{str}"
    FileUtils.cd "#{str}"
    FileUtils.mkdir "app"
    FileUtils.cd "app"
    FileUtils.mkdir "controller"
    FileUtils.mkdir "models"
    FileUtils.mkdir "views"
    FileUtils.chdir "../"
    FileUtils.mkdir "config"
    FileUtils.cd "config"
    FileUtils.touch "database.yml"
    FileUtils.touch "routes.rb"
    FileUtils.chdir "../"
    FileUtils.touch "config.ru"

  end

end

obj = CreateSkeleton.new
puts " Enter the Application name."
name = gets.gsub!(/\s/,'')
if name.nil?
  puts " Application name is empty. "
else
  obj.create_folder(name)
end
