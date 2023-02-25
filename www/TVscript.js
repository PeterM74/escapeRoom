var scanlines = $('.scanlines');
var tv = $('.tv');
var ShinyResponse = null;


// ref: https://stackoverflow.com/q/67322922/387194
var __EVAL = (s) => eval(`void (__EVAL = ${__EVAL}); ${s}`);


// Delete below when ready, function not used
function checkResponse() {
  
  if (window.ShinyResponse !== null) {
    
    return(0);
    
  } else {
    
    window.setTimeout(checkResponse, 100);
    
  }
  
};

var term = $('#terminal').terminal(function(command, term) {
    var cmd = $.terminal.parse_command(command);
    cmd.time = new String(Date.now()).toString();

    // Send to Shiny
    Shiny.setInputValue("TermInput", cmd);
    
    //Receive from Shiny
    term.pause();
    Shiny.addCustomMessageHandler("EchoResponse", function(EchoResp) {
        
        window.ShinyResponse = EchoResp;
        
        if (window.ShinyResponse.substring(0, 5) === "ERROR") {
          
          var ErrorMsg = window.ShinyResponse.slice((window.ShinyResponse.length - 6) * -1);
          term.error(new String(ErrorMsg)).resume();
          
        } else {
          
          window.term.echo(new String(window.ShinyResponse)).resume();
          
        };
        
        
      });
    
    
    
    
    //window.ShinyResponse = null;

    
    
    //if (command !== '') {
    //    try {
    //        var result = __EVAL(command);
            //if (result && result instanceof $.fn.init) {
            //    term.echo('<#jQuery>');
            //} else if (result && typeof result === 'object') {
            //    tree(result);
            //} else if (result !== undefined) {
            //    term.echo(new String(result));
            //}
    //    } catch(e) {
            //term.error(new String(e));
    //        term.error(new String("Uh oh, don't know"))
    //    }
    
}, {
    name: 'js_demo',
    onResize: set_size,
    exit: false,
    // detect iframe codepen preview
    enabled: $('body').attr('onload') === undefined,
    greetings: false,
    onInit: function() {
        set_size();
        this.echo(" ________  ________          _____ ______   ________  ___       ___  ___  _____ ______      ");
        this.echo("|\\   ___ \\|\\   __  \\        |\\   _ \\  _   \\|\\   __  \\|\\  \\     |\\  \\|\\  \\|\\   _ \\  _   \\    ");
        this.echo("\\ \\  \\_|\\ \\ \\  \\|\\  \\       \\ \\  \\\\\\__\\ \\  \\ \\  \\|\\  \\ \\  \\    \\ \\  \\\\\\  \\ \\  \\\\\\__\\ \\  \\   ");
        this.echo(" \\ \\  \\ \\\\ \\ \\   _  _\\       \\ \\  \\\\|__| \\  \\ \\   __  \\ \\  \\    \\ \\  \\\\\\  \\ \\  \\\\|__| \\  \\  ");
        this.echo("  \\ \\  \\_\\\\ \\ \\  \\\\  \\|       \\ \\  \\    \\ \\  \\ \\  \\ \\  \\ \\  \\____\\ \\  \\\\\\  \\ \\  \\    \\ \\  \\ ");
        this.echo("   \\ \\_______\\ \\__\\\\ _\\        \\ \\__\\    \\ \\__\\ \\__\\ \\__\\ \\_______\\ \\_______\\ \\__\\    \\ \\__\\");
        this.echo("    \\|_______|\\|__|\\|__|        \\|__|     \\|__|\\|__|\\|__|\\|_______|\\|_______|\\|__|     \\|__|");
        this.echo("");
    },
    onClear: function() {
        console.log(this.find('video').length);
        this.find('video').map(function() {
            console.log(this.src);
            return this.src;
        });
    },
    prompt: '> '
});
// for codepen preview
if (!term.enabled()) {
    term.find('.cursor').addClass('blink');
}
function set_size() {
    // for window height of 170 it should be 2s
    var height = $(window).height();
    var width = $(window).width()
    var time = (height * 2) / 170;
    scanlines[0].style.setProperty("--time", time);
    tv[0].style.setProperty("--width", width);
    tv[0].style.setProperty("--height", height);
}


cssVars(); // ponyfill