task :install do
  install_zplugin
  install_zsh_config
end

private

def run(cmd)
  puts "[Running] #{cmd}"
  `#{cmd}` unless ENV['DEBUG']
end

def install_zplugin
  zplugin = "source ~/.zplugin/bin/zplugin.zsh"
  File.open("#{ENV['HOME']}/.zshrc", 'a+') do |zshrc|
    if zshrc.readlines.grep(/#{Regexp.escape(zplugin)}/).empty?
      zshrc.puts(zplugin)
    end
  end
end

def install_zsh_config
  source_config_code = "for config_file ($HOME/.gdf/zsh/*.zsh) source $config_file"
  File.open("#{ENV['HOME']}/.zshrc", 'a+') do |zshrc|
    if zshrc.readlines.grep(/#{Regexp.escape(source_config_code)}/).empty?
      zshrc.puts(source_config_code)
    end
  end
  oh_my_zsh = "source $ZSH/oh-my-zsh.sh"
  filename = "#{ENV['HOME']}/.zshrc"
  zshrc = File.readlines(filename)
  run %{ awk '!/source $ZSH/' #{filename} > ~/.temp && mv ~/.temp #{filename} }
  run %{ echo source $ZSH/oh-my-zsh.sh | sudo tee -a "#{ENV['HOME']}/.zshrc" }
end

def write_git_user_file
  puts "======================================================"
  puts "Git user configuration."
  puts "======================================================"

  file_name = "#{ENV["HOME"]}/.gitconfig.user"

  if File.exists?(file_name)
    puts "gitconfig.user file already exists, skipping."
  else
    gh_user = text_input("Git name")
    gh_email = text_input("Git email")

    File.open(file_name, 'w') do |f|
      f.puts("[user]\n  name = #{gh_user}  email = #{gh_email}")
    end
  end
end
