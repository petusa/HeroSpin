# HeroSpin
iOS mobile app for picking a random superhero movie to watch

Instructions for opening the [Live demo](http://petusa.github.io/herospin.html):

- It is recommended to use a desktop browser, and if you already opened it, it is better to force refresh the page (by pressing Ctrl/CMD + R keys).
- With the tool (appetize.io) I am using for presenting a "live"/streamed simulator version, you may expect some delay, latencies and some clicks can stuck in, so please be patient to get some response from the app. I tested the app carefully and should be robust enough to always give some interaction, unless appetize.io streaming makes some misbehaviour which I experienced. 

Instructions for building the source from XCode:

- pull/fetch the latest version, or clone it from scratch to a local folder on your local machine, github.com/petusa/HeroSpin
- as a prerequisite, you need to use CocaPods as the dependency manager, to read about it and how to install cocoapads visit page: https://cocoapods.org/ 
- when CocoPods is installed you should be able to run 'pod' command from under any folder in your Terminal
- run 'pod install' from the local folder where you cloned the HeroSpin source code to (where .git is located too), this should grab all the dependencies needed for the XCode project to run
- (alternatively, if you can see the 'pod install' command waiting too long, you can run simply 'pod install --no-repo-update', but this is for mainly second runnings, usually you can call 'pod install' unchanged, multiple times, just these are what I experienced)
- after successfully installing the dependencies, you should open the XCode workspace (HeroSpin.xcworkspace and not the project!), as only the workspace will list both the HeroSpin project and installed dependencies under a second Pods project (for opening the workspace you can simple Shift + Enter on the HeroSpin.xcworkspace from your Finder)
- after opening CMD+Shift+B commands will start building your HeroSpin project (unless XCode immediately starts building it)
- CMD + R will run the project on any installed Simulator or attached device as per your preference, you can select the target in the top tool bar by choosing a scheme
- of course, there might be some settings which were setup to my environment (I tried to use relative paths everyhere), but this cases, XCode might offer you some Fix Issues dialogs questions, which are better to accept.


Look this [README in raw format](http://github.com/petusa/HeroSpin/raw/master/README.md) and a bigger screen to see through the ASCII jungle below ;) 

         :+'
       @....#
      `@....#...`
    #,..,...#...;
    '...#....`...@
   +.,.......@....# `
   ..;...#.....`...+
   @..+...#...;....,;#':'
   #..`..`.+.`.+....,...@                      ,@@@@;
    ,.`'....@.......:...@                     #@@@@@@@@  .
    @...'`.....:@,.`+...@                     @@@@@@@@@@@@@.
     +`.....,#.....`+...+                     @@@@@@@@@@#@@@
     .+`.'#,......,,....`@                    @@@@@@@@@@@#+@@
      #.........#..+,#.....                  #@;@@@@@@@@...:@,
      @....`.',..#,........                  @#.@@@.@@#....#@@
      @....,.`..'.........                   @+.`@#;.......@@@
      '...:`....#........#                   ++...,@@.......@@
       ,`......+........`,                   +@.,@@:`..;@:'.#@                                     '@@@@@`
       #.......#........#                    :@.@@;..:@:..`.;@;                                 `@';;;;;;'@.
        #@......:......#         @';;#        @,...;`..:....,.#`                               #+;;;;;;;;;;'#
          +@@:...@...@:@+`     ,+;;;;;',     `'.;:..`..........:                             .@;;;;;;;;;;;;;;@`
          @+...........'+@`   ,';;;;;;;;+     :....:..........+;                            :#;;;;;;;;;;;;;;;;'; `
          @'#.........@'''@; `+;;;;;;;;;;##@@:`....'...........:                           #+;;;;;;;;;;;;;;;;;;;#
          @';#......`@'''';#.@;;;;;;;;;;;;';;;.....,,+`........`                          #;;;;;;;;;;;;;;;;;;;;;+@
         `@'''+:...++'''''''@;##''+@';;;;;+;;;,........`......+                          @;;;;;;;;;;;;;;;;;+#.
         `@''';';'';''''''';#@@''''';@;;;;;#;;;`...............'                        #;;;;;;;;;;;;;;+@.
         `@''''''''';'''''''';'#'''';;#;;;;+;;;...`....`.......# :#+',    `            @;;;;;;;;;;;;#+
          @''''''''''''''''';'';#;'''''#;;;;+;;;...:++,........+';;;;;''@;;#          #;;;;;;;;;;#@`
          @'''''''''''''''''';'''#''''''@;;;@;;#......`.........;;;;;;;;;;;;@@@;     #;;;;;;;;;@: `
          #'''''''''''''''''+'''''#''''''#;;';;@.............'..@;;;;;;+;;;;@'''#:  #;;;;;;;;@,
          +#'''''''''''''''''''''''''''''';;;;;'.............`..@;;;;;;#;;;;#''''+;@;;;;;;'@'
           @''''''''''''''''''''''''''''''@;;+;;'...........@.....+;;;;+;;;;''''''@;;;;;;@'''
           @''''''''''''''''''''''''''''''';;@;;'.........`:.....'.+;;;';;;''''''''#;;;@'''''#
            @''''''''''''''''''''''''''''''@;@;;'+........`........#;;;+;;;@'''''''@;+#'''''''@
            '+'''''''''''''''''''''''''''''';#;;'.#.....,':........:;;;#;;;'''''';'+@''''''''''''##`
             `@@#;''''''''''''''''''''''''''#+;;'...................;;;';;@''''''''''''''''''''''''+#
                '@';''''''''''''''''''''''''+;;;+.............,.....;;;;;;'''''''''''''''''''''''''''#
                  @#'''''''''''''''''''''''';;';#.............@.....;;';;#''''''';'+'''''''''''''''''';
                   @@''''''''''''''';'''''''';#;+.....+.......:....;;;';#''''''''''@''''''''''''''''''@
                    ;@+''''''''''''+''''''''''''#,.....#...........+;;;;''''''''''++''''''#@@@#'''''''+`
                     `@#'''''''''''+''''''''''''''+'....+``..'.....';';+''''''''''#'''''''..``.+''''''''
                       @@''''''''''''''''''''''''''';#;...`..;.....;';#'''''''#';@'''''@....'+.`'''''''#
                        :@#'''''''';#''''''''''''''';'';+#..`.....:;;#''''''''@'@#@#'+#....`..+.#''''''#
                          #@@+';''''#'''''''''''''''''''''''+@',..';';''''''''@@;';'......:.`.'.+'''''''
                           `@''++''''''''''''''''''''''''''';''';'''''''''''''#'''''`.....+#..;.'''''''.
                            @''''''''@';'''''''''''+;'#+'''''''''''''''''''''''''';......'++....''''''@
                            :#''''';'#''''''''''';#;;;;;;;;;'+###++++;'''''''@;''''.....#`#+'::@''''''@
                             @''''''''+''''''''';';#,:#;;;;;;;;;;;;;;+'''''';#';'''...+,..,.`..''''''+;
                             #+'''''''@''''''''';;::+';;;;+###';;':';'''''''+'''';'......#+...'''''''@
                              @'''''''';''''''+;':,';;;#:,,,,,:,#;;;''+'''';@#@@@#+#@;'#+'''+'''''''@,
                              #''''''''@'''''+;#::;;;;:,,:::,::::+;;#:;#'''+'''''''''''''''''''''''#+
                               @;''''''+'''''#;;;;;;;#:,,,,,:,,,:,:,,:';'''#''''''''''''''''''''''##
                               ,#'''''';@'''''#;;;;;;;#;::::;;;;;:,,,;;#''@''''''''''''''''''''''@;
                                #+''''''#''''''+;;;;;;;;;;;;;;;;;;;#;;+';@@@'''''''''''''''''+@@@
                                 @#''''''@'''''''+;;;;;;;;;;;;;;;;;;'';'@@@@@#'''#@;`   .,::,.
                                  ##''''''@''''';'#;;;#,:,,,::::';;#'''#@@@@''@+@
                                   +#''''''@''''''''#;'+;#;+:::#;;#;;@#:@@@'''''@.
                                    ,@+''''''''''''';'';;;;;;;;;;+'@+':+@@'''''';#@
                                      @@'''';'''++'''''#;;#';+;###'''+:@@';''''''''@
                                      `,@#'''''''';;'+#@##;##;+'';;+@@@@''''''''''''@``
                                         ;@+;''''''''''';'''''''''#,:@@''''''''''''''@.
                                           ;@';'''''''''''''''''+,:,@@@'''''''''''''''@.
                                             ,@'''''''''''''''#::':@@@'''''''''''''''''@`
                                               ,@''''''''''+@,::,@@@@@''''''''''''''''';@
                                                @,,'+#@@#;,:+::'@@@@@#'''''''''''''''''''#`
                                                 @':,:,#@:,::@@@@@@@@''''''''''''''''''''+;
                                                 #@@@@@@@@@@@@@@@@@@@'''''''''''''''''''''@
                                                  @@@@@@@@@@@@@@@@@@#@+'''''''''''''''''''+.
                                                  `@@@@@@@@@@@@@#''''#,@';'''''''''''''''''@
                                                   #@@@@@@@@+'''''''''# @+'''''''''''''''''@
                                                    #+;;''''''''''''''+  ,@''''''''''''''''#
                                                     @#''''''''''''''''@   @''''''''''''''''`
                                                      +#';'''''''''''''''   @#'''''''''''''':
                                                       `@+''''''''';''''+`   '#'''''''''''''+
                                                          @#'''''''''#'';#   `;@''''''''''''+
                                                            `@@+;';'''+'''@   ;;@'''''''''''+
                                                                .##''';''+'#  `;;@'''''''''':
                                                                 #;''''''+';@  ,;;++''';'''+
                                                                 .'''''''+;;;## +;;;@''''''#
                                                                  @';+++'';;;;';`@;;;;#@@@@,`
                                                                   +#'';;;;;;;;; `+;;;;;.`
                                                                     :@@@@+++;;;+ ';;;;;#
                                                                             #;;;# @;;;;;'
                                                                             `';;;.`';;;;#
                                                                              #;;;; `+;;;;`
                                                                               #;;;#  @;;;'
                                                                                @;;;.   ##;
                                                                                 '#;+
