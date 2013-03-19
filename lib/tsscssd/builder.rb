module Tsscssd
  class Builder
    @output
    def initialize(config,source)
      setup_document(config)
      source.files.each do |file|
        write_section(file)
      end
      write_nav(source.files)
    end
    
    def setup_document(config)
      @output = File.new(config[:output], "w")
      @output.puts '<!DOCTYPE html>'
      @output.puts ' <html>'
      @output.puts '   <head>'
      @output.puts '     <title>' + config[:appname] + ' Styleguide</title>'
      puke_style
      @output.puts '   </head>'
      @output.puts '   <body>'
      @output.puts '     <div class="titlebar">' + config[:appname] + ' Styleguide!</div>'
      @output.puts '     <div class="content">'
    end
    
    def write_section(section)
      @output.puts '       <div class="section" id="' + section.prettyName + '">'
      @output.puts '         <table class="header">'
      write_header(section.header)
      @output.puts '          <tr><td>Location</td><td>' + section.fileName + '</td></tr>'
      write_imports(section.imports) if section.imports?
      @output.puts '         </table>'
      write_comments(section.comments)
    end
    
    def write_header(header)
      header.each do |head|
        @output.puts '          <tr>'
        @output.puts '           <td>' + head[:key] + '</td>'
        @output.puts '           <td>' + head[:value] + '</td>'
        @output.puts '          </tr>'
      end
    end
    
    def write_imports(imports)
      @output.puts '           <tr>'
      @output.puts '             <td>Depends on</td>'
      @output.puts '           <td>'
      imports.each do |import|
        @output.puts '              ' + import
      end
      @output.puts '           </td>'
      @output.puts '          </tr>'
    end
    
    def write_comments(comments)
      if comments.length > 0
        @output.puts '         <table class="selectors">'
        @output.puts '           <thead>'
        @output.puts '             <tr>'
        @output.puts '               <th class="line-number">Line #</th>'
        @output.puts '               <th class="selector-cell">Selector</th>'
        @output.puts '               <th>Description</th>'
        @output.puts '             </tr>'
        @output.puts '           </thead>'
        @output.puts '           <tbody>'
        comments.each do |comment|
          @output.puts '             <tr>'
          @output.puts '               <td class="line-number">' + comment[:lineNumber].to_s + '</td>'
          @output.puts '               <td class="selector-cell">' + comment[:selector] + '</td>'
          @output.puts '               <td>' + comment[:comment] + '</td>'
          @output.puts '             </tr>'
        end
        @output.puts '         </tbody>'
        @output.puts '       </table>'
      else
        @output.puts '<div class = "empty-section">Woah...this file contains no comments, dude! Add some to make it more <div class="doper">doper</div>.</div>'
      end
    end
    
    def write_nav(files)
      @output.puts '   <div class="nav">'
      i = 0
      files.each do |file|
        if i == 0
          @output.puts '     <div class="nav-item current-nav">'
        else
          @output.puts '     <div class="nav-item">'
        end
        @output.puts '       <a href="#' + file.prettyName + '" onclick="document.getElementsByClassName(\'current-nav\')[0].className=\'nav-item\';event.target.parentElement.className+=\' current-nav\';">' + file.prettyName + '</a>'
        @output.puts '     </div>'
        i+=1
      end
      @output.puts '   </div>'
    end
    
    def puke_style
      @output.puts "<style>html { margin: 0px; padding: 0px; }

      body { font-family: Arial; color: #444; }

      .titlebar, .nav { position: fixed; }

      .titlebar { top: 0px; left: 0px; width: 100%; height: 30px; z-index: 1; }
      .nav { top: 50px; left: 0px; width: 200px; background-color: #F0F7FF; }
      .content { position: absolute; padding: 20px; left: 200px; right: 0px; top: 0px; }

      .titlebar { 
        font-size: 28px;
        padding: 10px;
        color: #00457c;
        border-bottom: 1px solid #a0cbed;
        text-shadow: 1px 1px 1px rgba(255,255,255,.7);
        background: rgb(242,249,254); /* Old browsers */
        /* IE9 SVG, needs conditional override of 'filter' to 'none' */
        background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2YyZjlmZSIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiNkNmYwZmQiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
        background: -moz-linear-gradient(top,  rgba(242,249,254,1) 0%, rgba(214,240,253,1) 100%); /* FF3.6+ */
        background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(242,249,254,1)), color-stop(100%,rgba(214,240,253,1))); /* Chrome,Safari4+ */
        background: -webkit-linear-gradient(top,  rgba(242,249,254,1) 0%,rgba(214,240,253,1) 100%); /* Chrome10+,Safari5.1+ */
        background: -o-linear-gradient(top,  rgba(242,249,254,1) 0%,rgba(214,240,253,1) 100%); /* Opera 11.10+ */
        background: -ms-linear-gradient(top,  rgba(242,249,254,1) 0%,rgba(214,240,253,1) 100%); /* IE10+ */
        background: linear-gradient(to bottom,  rgba(242,249,254,1) 0%,rgba(214,240,253,1) 100%); /* W3C */
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#f2f9fe', endColorstr='#d6f0fd',GradientType=0 ); /* IE6-8 */

      }
      a { color: #0079c1; }

      .nav .nav-item {
        padding: 10px;
        border-bottom: 1px solid rgba(160, 203, 237, .5);
        border-right: 1px solid #a0cbed;
      }

      .nav .nav-item:last-child { border-bottom: 1px solid #a0cbed; border-radius: 0 0 5px 0;}

      .nav .current-nav { background-color: #fff; border-right: 0; font-weight: bold; }

      .section {
        position: relative;
        margin-bottom: 99px;
        text-shadow: 1px 1px 1px rgba(255,255,255,.7);
        padding-top: 55px;
      }

      table { border-collapse: collapse; width: 100%;}

      table.header {
        padding: 10px 0px;
        border: 1px solid rgba(160, 203, 237, .5);
        border-bottom: 0;
        background: rgb(247,247,247); /* Old browsers */
        /* IE9 SVG, needs conditional override of 'filter' to 'none' */
        background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2Y3ZjdmNyIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjQ3JSIgc3RvcC1jb2xvcj0iI2Y2ZjZmNiIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiNlZGVkZWQiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
        background: -moz-linear-gradient(top,  rgba(247,247,247,1) 0%, rgba(246,246,246,1) 47%, rgba(237,237,237,1) 100%); /* FF3.6+ */
        background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(247,247,247,1)), color-stop(47%,rgba(246,246,246,1)), color-stop(100%,rgba(237,237,237,1))); /* Chrome,Safari4+ */
        background: -webkit-linear-gradient(top,  rgba(247,247,247,1) 0%,rgba(246,246,246,1) 47%,rgba(237,237,237,1) 100%); /* Chrome10+,Safari5.1+ */
        background: -o-linear-gradient(top,  rgba(247,247,247,1) 0%,rgba(246,246,246,1) 47%,rgba(237,237,237,1) 100%); /* Opera 11.10+ */
        background: -ms-linear-gradient(top,  rgba(247,247,247,1) 0%,rgba(246,246,246,1) 47%,rgba(237,237,237,1) 100%); /* IE10+ */
        background: linear-gradient(to bottom,  rgba(247,247,247,1) 0%,rgba(246,246,246,1) 47%,rgba(237,237,237,1) 100%); /* W3C */
        filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#f7f7f7', endColorstr='#ededed',GradientType=0 ); /* IE6-8 */

      }

      table.header tr td:first-child , th { color: #00457c; font-weight: bold; }
      table.header tr td:first-child { 
        width: 150px; 
        border-right: 1px solid #e6e6e6;
        -webkit-box-shadow:  2px 0px 0px 0px rgba(255, 255, 255, .2);
        box-shadow:  2px 0px 0px 0px rgba(255, 255, 255, .2);
      }

      table.header tr:first-child { font-weight: bold; }

      table.selectors { border: 1px solid rgba(160, 203, 237, .5);}
      table.selectors thead tr{ 
        text-align: left;
        background-color: rgba(152,190,222,.5);
        border-bottom: 1px solid #a0cbed;
        border-top: 1px solid #a0cbed;
      }
      table.selectors tr { height: 33px; background-color: #fff; }

      table.selectors head tr, table.selectors tr:nth-child(even) { background-color: rgba(160, 203, 237, .3); }
      table.selectors tbody tr:hover { 
        background-color: rgba(160, 203, 237, .5);
      }

      th, td { padding: 4px 10px; }

      .line-number { width: 50px; text-align: right; }
      .selector-cell { width: 187px; }

      .empty-section {
        font-size: 1.1em;
        text-align: center;
        padding: 15px;
        border: 1px solid rgba(160, 203, 237, .5);
      }

      @-webkit-keyframes doper {
          0%{
              -webkit-transform: rotateY(30deg);
              color: #444;
          }
          50%{
              -webkit-transform: rotateY(-30deg);
              color: #19CF19
          }
          100%{
              -webkit-transform: rotateY(30deg);
              color: #444;
          }
      }

      .doper {
          -webkit-animation: doper 1s linear infinite;
          display: inline-block;
      }</style>"
    end    
  end
end