require 'pathname'
require 'fileutils'

module Tsscssd
  class Runner

    attr :input
    attr :config
  
    def initialize(input, config = {})
      @input  = input.to_s[-1] == "/" ? input[0...-1] : input # gracefully ignore trailing slash on input directory name
      @config = config
      @config[:appname]     ||= Tsscssd.appname         || 'My dope app'
      @config[:stylesheets] ||= Tsscssd.stylesheets     || Dir.pwd + '/app/assets/stylesheets/'
      @config[:output]      ||= Tsscssd.output          || Dir.pwd + '/app/public'
      @config[:type]        ||= Tsscssd.type            || 'scss'
      @config[:skip]        ||= Tsscssd.skip            || ['normalize']
    end

    def run!(&block)
      printer
      styleguide = Tsscssd::StyleGuide.new
      snag_stylesheets(styleguide)
      Tsscssd::Builder.new(@config, styleguide)
    end
    
    def printer
      puts '
      /$$$$$$$$/$$$$$$  /$$$$$$   /$$$$$$  /$$$$$$  /$$$$$$  /$$$$$$$ 
      |__  $$__/$$__  $$/$$__  $$ /$$__  $$/$$__  $$/$$__  $$| $$__  $$
         | $$ | $$  \__/ $$  \__/| $$  \__/ $$  \__/ $$  \__/| $$  \ $$
         | $$ |  $$$$$$|  $$$$$$ | $$     |  $$$$$$|  $$$$$$ | $$  | $$
         | $$  \____  $$\____  $$| $$      \____  $$\____  $$| $$  | $$
         | $$  /$$  \ $$/$$  \ $$| $$    $$/$$  \ $$/$$  \ $$| $$  | $$
         | $$ |  $$$$$$/  $$$$$$/|  $$$$$$/  $$$$$$/  $$$$$$/| $$$$$$$/
         |__/  \______/ \______/  \______/ \______/ \______/ |_______/
         '
      puts 'Crafting the styleguide for ' + @config[:appname] + '...'
      puts ''
      puts 'over in that ' + @config[:output] + ' file ...'
      puts ''
      puts 'by pulling from ' + @config[:stylesheets] + '...'
      puts ''
      puts 'which is chock full of ' + @config[:type] + ', homie!'
      puts ''
      puts 'Pop that shit open in a browser!'
      puts ''
    end
  
    private

    def appname
      config[:appname]
    end

    def stylesheets
      config[:stylesheets]
    end

    def output
      config[:output]
    end
    
    def snag_stylesheets(guide)
      Dir.glob('./app/assets/stylesheets/unity/*.' + @config[:type]).each do |file|
        fn = file.split('/')
        fn = fn[fn.length-1].split('.')[0]
        if @config[:skip].index(fn) == nil
          guide.addFile(file)
        end
      end
    end
  end
end