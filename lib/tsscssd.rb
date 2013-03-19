require "tsscssd/version"
module Tsscssd
  
  LIB         = File.dirname(__FILE__)
  
  autoload :Runner,  File.join(LIB, 'tsscssd/runner')
  autoload :Builder,  File.join(LIB, 'tsscssd/builder')

  def self.run!(input, config = {}, &block)
    Runner.new(input, config).run!(&block)
  end

  class << self
    attr_accessor :appname
    attr_accessor :stylesheets
    attr_accessor :output
    attr_accessor :type
    attr_accessor :skip
  end  
  
  class StyleGuide
    def initialize
      @files = []
    end
    def files
      @files
    end
    def addFile(file)
      cssFile = Tsscssd::CssFile.new(file)
      @files.push(cssFile)
    end
  end
  
  class CssFile
    def initialize(fileName)
      @fileName = fileName
      fn = fileName.split('/')
      fn = fn[fn.length-1]
      fn = fn.split('.')[0]
      @prettyName = fn
      @header = []
      @imports = []
      @comments = []
      @lineNumber = 0
      @inComment = false
      @comment = ''
      parseFile
    end
    def fileName
      @fileName
    end
    def prettyName
      @prettyName
    end
    def header
      @header
    end
    def imports
      @imports
    end
    def imports?
      @imports.length > 0 ? true : false
    end
    def comments
      @comments
    end
    def comments?
      @comments.length > 0 ? true : false
    end
    def parseFile
      File.open(fileName) do |file|
        while @line = file.gets
          @lineNumber = @lineNumber + 1
          if @line
            @line = @line.chomp
            @words = @line.split
            case @words[0]
            when '/*'
              #Begin the header comments. May need this for later.
            when '*'
              #puts 'Header Comment'
              headerComment = @line.split('*')
              value = @line.split('- ')
              value = value[value.length-1]
              key = headerComment[1].split[0]
              @header.push({key:key, value:value})
            when '*/'
              #End header comments. May need this for later.
            when '@import' # Collect those imports!
              #puts 'In imports | ' + @words[1].split("'")[1]
              @imports.push(@words[1].split("'")[1])
            when '//' #ID the comment. Mark as inComment for the next pass to grab the right hand side.
              #puts 'Inline Comment'
              if @inComment == false
                @inComment = true
                @comment = @line.split('// ')
                @comment = @comment.join.chomp
              end
            else
              if @inComment == true   # grab the selector/variable for the comment we have ID'ed
                if @line[0] == '$'
                  @line = @line.split(':')[0]
                elsif @line.split('{')[0].length < 2
                  @line = @line.chomp(' {')
                else
                  @line = @line.split('{')[0]
                end                
                @comments.push({lineNumber:@lineNumber,selector:@line,comment:@comment})
                @inComment = false
              end
            end
          end
        end
      end
    end
  end
end
