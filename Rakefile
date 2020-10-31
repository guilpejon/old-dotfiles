task :install do
  install_zplugin
  install_zsh_config
end

private

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
