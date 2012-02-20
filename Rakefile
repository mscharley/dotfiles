require 'rake'
require 'erb'

# Based heavily on the Rakefile used by Ryan Bates dotfiles project.
# The original file was released under an MIT licence also.
# You may find the original file at:
# https://raw.github.com/ryanb/dotfiles/350081e48d700210d619c4905078eb7fb0247813/Rakefile

desc "Install the dot files into user's home directory."
task :install do
  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README.md LICENSE].include? file
    
    filename = get_filename(file)
    is_example = (file =~ /\.example$/)

    if is_example and File.exist?(File.join(ENV['HOME'], ".#{filename}"))
      # Do nothing if an example was already installed
    elsif File.exist?(File.join(ENV['HOME'], ".#{filename}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{filename}")
        puts "identical ~/.#{filename}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{filename}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{filename}"
        end
      end
    else
      link_file(file)
    end
  end
end

def get_filename(file)
  file.sub(/\.(?:example|erb)$/, '')
end

def replace_file(file)
  system %Q{rm -rf "$HOME/.#{get_filename(file)}"}
  link_file(file)
end

def link_file(file)
  if file =~ /\.erb$/
    puts "generating ~/.#{get_filename(file)}"
    File.open(File.join(ENV['HOME'], ".#{get_filename(file)}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file), nil, '<>').result(binding)
    end
  elsif file =~ /\.example$/
    puts "copying ~/.#{get_filename(file)}"
    File.open(File.join(ENV['HOME'], ".#{get_filename(file)}"), 'w') do |new_file|
      new_file.write File.read(file)
    end
  else
    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end

