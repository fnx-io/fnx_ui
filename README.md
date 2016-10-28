"Desktop first" pure Dart angular2 components for a rapid development of "form-heavy" apps - CMS,
backend administrations, ... 

# Desktop first? What kind of heresy is that?
 
Yeah, we all love our smartphones. But there are still many applications, which are operated almost exclusively on desktop.
Backend administrations, information systems, "form heavy" apps ... Purpose of this library is to create a collection
of angular2 components optimized for this particular type of applications.

# It doesn't work on mobile?

Yes it does, and we are trying to keep it this way. But - the emphasis is on desktop, mouse, keyboard.

# CSS

        cd stylesheet
        gulp devel
        
Then open http://localhost:8085/

        gulp release

Then see stylesheet/_dist/.
         
# Angular2 components
         
         cd showcase
         pub get
         pub serve
         
Then see http://localhost:8080/

# Documentation

Unfortunately there is not much documentation yet :-)

Please see examples:

http://demo.fnx.io/fnx_ui/css/ - set of CSS examples. A lot of things in fnx|ui is solved in CSS only.
You can see the source code of each example by clicking on the red \[<>] button. We use this demo
to create CSS, so it's occasionally animated using jQuery. Final components are pure Dart, though. 

http://demo.fnx.io/fnx_ui/ng2/ - set of Angular 2 Examples with source codes.

Some documentation (mostly CSS part) is appearing here:
 
https://github.com/fnx-io/fnx_ui/wiki  

If you are interested, complex example project is: https://github.com/fnx-io/rpg_manager
  
Which you can see online: http://demo.fnx.io/rpg-manager/

# Getting started

Your pubspec.yaml should look much like this:

    name: your_app
    ...
    dependencies:
      angular2: any <-- for now, let fnx|ui decide which one, we are trying to keep up with Angular2
      browser: ^0.10.0
      dart_to_js_script_rewriter: ^1.0.1
      fnx_ui:
        git:
          url: https://github.com/fnx-io/fnx_ui
          ref: master
       ...
    transformers:
    - angular2:
        platform_directives:
        - 'package:angular2/common.dart#COMMON_DIRECTIVES'
        - 'package:angular2/common.dart#CORE_DIRECTIVES'
        - 'package:angular2/router.dart#ROUTER_DIRECTIVES'
        - 'package:fnx_ui/fnx_ui.dart#FNX_UI_COMPONENTS'
        entry_points: web/main.dart
    - dart_to_js_script_rewriter

In your entry script (main.dart), initialize app as usual, but provide custom exception handler:

      bootstrap(YourRootComponent, [
          ROUTER_PROVIDERS,
          provide(LocationStrategy, useClass: HashLocationStrategy),
          provide(ExceptionHandler, useValue: new FnxExceptionHandler()) // !!!
      ]);

In the template of your root component, please use <fnx-app> element and wrap whole application into it. This element
takes care of notifications, alerts, error handling.

    <fnx-app>
        <div class="layout--header">
            <header>
                ...
            </header>
            <main>
                ...
                
Also don't forget to link stylesheets:
                
    <!-- Main CSS -->            
    <link rel="stylesheet" href="packages/fnx_ui/css/fnx_ui.css">
    
    <!-- Theme and accent of your choice -->
    <link rel="stylesheet" href="packages/fnx_ui/css/theme_grey.css">
    <link rel="stylesheet" href="packages/fnx_ui/css/theme_brown.css">
                
And that's about it. Please dive into examples, find what you like
or what you want to use and see the source code.

Any feedback is more then welcome: tomucha@gmail.com